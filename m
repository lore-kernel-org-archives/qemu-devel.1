Received: from eggs.gnu.org ([2001:4830:134:3::10]:56960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ceLpK-0008BW-EZ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ceLpH-0007Sy-6y
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:10:26 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:8704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ceLpG-0007Ot-Bu
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:10:23 -0500
References: <1487224821-120916-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487224821-120916-4-git-send-email-zhang.zhanghailiang@huawei.com>
	<CAJ+F1CLMKKT_xv4Z5NNfd7rYzcKyrHri=Z7-QSWLoMX0DGBk+Q@mail.gmail.com>
	<58A59FD9.3080900@huawei.com>
	<CAJ+F1C+KqMTUFELHnY0pWBVU+SPZmhZSoHVvwjBu=Ki23E0jGA@mail.gmail.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58A5A4A6.1000301@huawei.com>
Date: Thu, 16 Feb 2017 21:09:58 +0800
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+KqMTUFELHnY0pWBVU+SPZmhZSoHVvwjBu=Ki23E0jGA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] char: remove the right fd been
 watched in qemu_chr_fe_set_handlers()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, pss.wulizhen@huawei.com, Paolo Bonzini <pbonzini@redhat.com>

On 2017/2/16 21:04, Marc-André Lureau wrote:
> Hi
>
> On Thu, Feb 16, 2017 at 4:49 PM Hailiang Zhang <
> zhang.zhanghailiang@huawei.com> wrote:
>
>> Hi,
>>
>> On 2017/2/16 18:40, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Thu, Feb 16, 2017 at 10:08 AM zhanghailiang <
>>> zhang.zhanghailiang@huawei.com> wrote:
>>>
>>>> We can call qemu_chr_fe_set_handlers() to add/remove fd been watched
>>>> in 'context' which can be either default main context or other explicit
>>>> context. But the original logic is not correct, we didn't remove
>>>> the right fd because we call g_main_context_find_source_by_id(NULL, tag)
>>>> which always try to find the Gsource from default context.
>>>>
>>>> Fix it by passing the right context to
>> g_main_context_find_source_by_id().
>>>>
>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>>>> ---
>>>>    chardev/char-io.c | 13 +++++++++----
>>>>    chardev/char-io.h |  2 ++
>>>>    chardev/char.c    |  2 +-
>>>>    3 files changed, 12 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/chardev/char-io.c b/chardev/char-io.c
>>>> index 7dfc3f2..a69cc61 100644
>>>> --- a/chardev/char-io.c
>>>> +++ b/chardev/char-io.c
>>>> @@ -127,14 +127,14 @@ guint io_add_watch_poll(Chardev *chr,
>>>>        return tag;
>>>>    }
>>>>
>>>> -static void io_remove_watch_poll(guint tag)
>>>> +static void io_remove_watch_poll(guint tag, GMainContext *context)
>>>>    {
>>>>        GSource *source;
>>>>        IOWatchPoll *iwp;
>>>>
>>>>        g_return_if_fail(tag > 0);
>>>>
>>>> -    source = g_main_context_find_source_by_id(NULL, tag);
>>>> +    source = g_main_context_find_source_by_id(context, tag);
>>>>        g_return_if_fail(source != NULL);
>>>>
>>>>        iwp = io_watch_poll_from_source(source);
>>>> @@ -146,14 +146,19 @@ static void io_remove_watch_poll(guint tag)
>>>>        g_source_destroy(&iwp->parent);
>>>>    }
>>>>
>>>> -void remove_fd_in_watch(Chardev *chr)
>>>> +void qemu_remove_fd_in_watch(Chardev *chr, GMainContext *context)
>>>>    {
>>>>        if (chr->fd_in_tag) {
>>>> -        io_remove_watch_poll(chr->fd_in_tag);
>>>> +        io_remove_watch_poll(chr->fd_in_tag, context);
>>>>            chr->fd_in_tag = 0;
>>>>        }
>>>>    }
>>>>
>>>> +void remove_fd_in_watch(Chardev *chr)
>>>> +{
>>>> +    qemu_remove_fd_in_watch(chr, NULL);
>>>> +}
>>>> +
>>>>
>>>
>>> I would just change the signature of remove_fd_in_watch() instead of
>>> introducing a function.
>>>
>>
>> In that case, i have to modify all the places call this helper,
>> About eleven places in six files，is it acceptable ？
>>
>
> Yes, that's fine.
>

OK, will fix it in v3, thanks.

>>
>> Thanks.
>>
>>>    int io_channel_send_full(QIOChannel *ioc,
>>>>                             const void *buf, size_t len,
>>>>                             int *fds, size_t nfds)
>>>> diff --git a/chardev/char-io.h b/chardev/char-io.h
>>>> index d7ae5f1..117c888 100644
>>>> --- a/chardev/char-io.h
>>>> +++ b/chardev/char-io.h
>>>> @@ -38,6 +38,8 @@ guint io_add_watch_poll(Chardev *chr,
>>>>
>>>>    void remove_fd_in_watch(Chardev *chr);
>>>>
>>>> +void qemu_remove_fd_in_watch(Chardev *chr, GMainContext *context);
>>>> +
>>>>    int io_channel_send(QIOChannel *ioc, const void *buf, size_t len);
>>>>
>>>>    int io_channel_send_full(QIOChannel *ioc, const void *buf, size_t len,
>>>> diff --git a/chardev/char.c b/chardev/char.c
>>>> index abd525f..5563375 100644
>>>> --- a/chardev/char.c
>>>> +++ b/chardev/char.c
>>>> @@ -560,7 +560,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>>>>        cc = CHARDEV_GET_CLASS(s);
>>>>        if (!opaque && !fd_can_read && !fd_read && !fd_event) {
>>>>            fe_open = 0;
>>>> -        remove_fd_in_watch(s);
>>>> +        qemu_remove_fd_in_watch(s, context);
>>>>        } else {
>>>>            fe_open = 1;
>>>>        }
>>>> --
>>>> 1.8.3.1
>>>>
>>>>
>>>>
>>> otherwise, looks good to me
>>>
>>
>> --
> Marc-André Lureau
>
