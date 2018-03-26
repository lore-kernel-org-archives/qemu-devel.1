Received: from eggs.gnu.org ([2001:4830:134:3::10]:59514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Z8F-0001A1-Kq
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Z8C-0002N4-Iv
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:54:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58570 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0Z8C-0002Mm-DP
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:54:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B566406802E
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 20:54:11 +0000 (UTC)
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-9-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <18a984c5-9656-20c6-b7e0-95141c851576@redhat.com>
Date: Mon, 26 Mar 2018 15:54:07 -0500
MIME-Version: 1.0
In-Reply-To: <20180326063901.27425-9-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 8/8] tests: qmp-test: add test for
 new "x-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/26/2018 01:39 AM, Peter Xu wrote:
> Test the new OOB capability. It's mostly the reverted OOB test, but

Helpful to mention which commit id has the reverts you are restoring. 
Looks like 4fd78ad. Are you also restoring the tests reverted in cc79760 
and a4f9092?

> differs in that:
> 
> - It uses the new qtest_init_with_qmp_format() to create the monitor
>    with the new monitor parameter "-mon x-oob"
> - Squashed the capability tests on greeting message
> - Don't use qtest_global any more, instead use self-maintained
>    QTestState, which is the trend
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tests/qmp-test.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 84 insertions(+)
> 

> +++ b/tests/qmp-test.c
> @@ -134,6 +134,89 @@ static void test_qmp_protocol(void)
>       qtest_quit(qts);
>   }
>   
> +/* Tests for Out-Of-Band support. */
> +static void test_qmp_oob(void)
> +{
> +    QTestState *qts;
> +    QDict *resp, *q;
> +    int acks = 0;
> +    const QListEntry *entry;
> +    QList *capabilities;
> +    QString *qstr;
> +    const char *cmd_id;
> +    const char *qmp_params = "-chardev socket,path=%s,nowait,id=char0 "
> +                             "-mon chardev=char0,mode=control,x-oob=on";

Again, I'd rather fold this into 7/8 qtest_init_without_qmp_handshake by 
changing "-qmp unix:%s,nowait" into "-chardev 
socket,path=%s,nowait,id=char0 -mon chardev=char0,mode=control" for ALL 
tests (as that always works), then have a bool that decides whether we 
also append ",x-oob=on" as needed.

> +
> +    qts = qtest_init_with_qmp_format(common_args, qmp_params);
> +
> +    /* Ignore the greeting message. */

Comment is wrong - you aren't ignoring it, but...

> +    resp = qtest_qmp_receive(qts);
> +    q = qdict_get_qdict(resp, "QMP");
> +    g_assert(q);
> +    capabilities = qdict_get_qlist(q, "capabilities");
> +    g_assert(capabilities && !qlist_empty(capabilities));

...actually inspecting what it contains.

> +    entry = qlist_first(capabilities);
> +    g_assert(entry);
> +    qstr = qobject_to(QString, entry->value);
> +    g_assert(qstr);
> +    g_assert_cmpstr(qstring_get_str(qstr), ==, "oob");
> +    QDECREF(resp);
> +

In the interest of getting this in -rc1, I will probably try and make 
the changes I've mentioned in this thread, and post a v2 along those 
lines; if you like my changes, I can send the pull request on my Tuesday 
morning instead of waiting for another round of back-and-forth.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
