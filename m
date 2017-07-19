Received: from eggs.gnu.org ([2001:4830:134:3::10]:44847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dXt7Q-0007Jb-2y
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dXt7M-0004rg-P7
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:50:40 -0400
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-8-eblake@redhat.com>
	<5d065e35-6ffd-8db0-f7bb-6be4c01f2a31@virtuozzo.com>
	<457d7370-1a21-cfbc-f8fa-4524d9c7e770@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0dca1a7e-afb7-e734-b53a-71740639ebfc@virtuozzo.com>
Date: Wed, 19 Jul 2017 20:50:32 +0300
MIME-Version: 1.0
In-Reply-To: <457d7370-1a21-cfbc-f8fa-4524d9c7e770@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 7/9] nbd: Implement NBD_OPT_GO on client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org

19.07.2017 20:12, Eric Blake wrote:
> On 07/19/2017 11:43 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 07.07.2017 23:30, Eric Blake wrote:
>>
>> [..]
>>
>>> +/* Returns -1 if NBD_OPT_GO proves the export @wantname cannot be
>>> + * used, 0 if NBD_OPT_GO is unsupported (fall back to NBD_OPT_LIST and
>>> + * NBD_OPT_EXPORT_NAME in that case), and > 0 if the export is good to
>>> + * go (with @info populated). */
>>> +static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
>>> +                      NBDExportInfo *info, Error **errp)
>>> +{
>>> +        if (reply.type == NBD_REP_ACK) {
>>> +            /* Server is done sending info and moved into transmission
>>> +               phase, but make sure it sent flags */
>>> +            if (len) {
>>> +                error_setg(errp, "server sent invalid NBD_REP_ACK");
>>> +                nbd_send_opt_abort(ioc);
>> server is already in transmission phase, so we cant send any options
>> more, shouldn't CMD_DISC be send here instead?
>>
>>> +                return -1;
>>> +            }
>>> +            if (!info->flags) {
>>> +                error_setg(errp, "broken server omitted
>>> NBD_INFO_EXPORT");
>>> +                nbd_send_opt_abort(ioc);
>> and here
> For NBD_OPT_INFO, receipt of NBD_REP_ACK implies the server is still in

hmm, nothing here about NBD_OPT_INFO.

> negotiation phase; transmission phases is only technically possible on
> NBD_OPT_GO.  That said, either error condition means the server is
> buggy, so it really doesn't matter what we do in response (we don't know
> if the server moved on to transmission phase or not, because it has
> already broken protocol by sending us garbage) - so trying to be
> courteous to tell the server we don't like their garbage vs. just
> silently disconnecting makes no real difference; even if the server
> doesn't like what we send (because it thinks we are out of phase), the
> server already broke protocol first.  Either way, we're going to
> disconnect, and the server has to mop up after its own bugs.

agree

>
> I don't think a followup patch is essential, but I'd also be okay with a
> patch that just eliminates the NBD_OPT_ABORT attempt and does a silent
> disconnect instead.
>

-- 
Best regards,
Vladimir
