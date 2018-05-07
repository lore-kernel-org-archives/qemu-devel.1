Received: from eggs.gnu.org ([2001:4830:134:3::10]:44596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fFaMK-0002bF-FA
	for qemu-devel@nongnu.org; Mon, 07 May 2018 03:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fFaMH-0006FO-BA
	for qemu-devel@nongnu.org; Mon, 07 May 2018 03:14:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54530 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fFaMH-0006FD-5t
	for qemu-devel@nongnu.org; Mon, 07 May 2018 03:14:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 426B0416F7BC
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 07:14:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1525326658-3078-1-git-send-email-thuth@redhat.com>
	<87k1slot93.fsf@dusky.pond.sub.org>
	<54f1bb8c-c61e-557a-952d-92ba1297e818@redhat.com>
Date: Mon, 07 May 2018 09:14:43 +0200
In-Reply-To: <54f1bb8c-c61e-557a-952d-92ba1297e818@redhat.com> (Thomas Huth's
	message of "Fri, 4 May 2018 16:55:57 +0200")
Message-ID: <87in80ym1o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] net: Silence 'has no peer' messages in
 testing mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> On 03.05.2018 13:47, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>>> When running qtests with -nodefaults, we are not interested in
>>> these 'XYZ has no peer' messages.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  net/net.c | 13 +++++++------
>>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/net.c b/net/net.c
>>> index 29f8398..58bf85e 100644
>>> --- a/net/net.c
>>> +++ b/net/net.c
>>> @@ -1427,12 +1427,13 @@ void net_check_clients(void)
>>>  
>>>      net_hub_check_clients();
>>>  
>>> -    QTAILQ_FOREACH(nc, &net_clients, next) {
>>> -        if (!nc->peer) {
>>> -            warn_report("%s %s has no peer",
>>> -                        nc->info->type == NET_CLIENT_DRIVER_NIC
>>> -                        ? "nic" : "netdev",
>>> -                        nc->name);
>>> +    if (!qtest_enabled() || nd_table[0].used) {
>> 
>> I understand the !qtest_enabled part, but not the nd_table[0].used
>> part.  Can you explain?
>
> Sure: I want to silence the message in qtest mode with -nodefaults.
> qtest mode enabled means qtest_enabled() returns true.
> -nodefaults enabled means nd_table[0].used is set to false.

.used is initialized to false, and becomes true on successful
net_init_nic() / net_param_nic().

The connection to -nodefaults is this:

    if (default_net) {
        QemuOptsList *net = qemu_find_opts("net");
        qemu_opts_set(net, NULL, "type", "nic", &error_abort);
#ifdef CONFIG_SLIRP
        qemu_opts_set(net, NULL, "type", "user", &error_abort);
#endif
    }

When default_net is true, we effectively add -net nic".  It is true
unless the user specifies any of -nodefaults, -netdev, -nic, -net.  So,
with the default nic, nd_table[0].used is true.  It's also true with
non-default nics specified with convenience options.

> So silence the message if qtest_enabled() && !nd_table[0].used.

Thus, silence the message if qtesting and the user specified -nodefaults
and didn't add nics with convenience options.

Two (possibly confused) questions:

1. The user can add nics without convenience options:

    $ upstream-qemu -display none -nodefaults -device e1000
    upstream-qemu: warning: nic e1000.0 has no peer

   Shouldn't we silence the warning then, too?

2. We already have code to silence the warning:

    /* Don't warn about the default network setup that you get if
     * no command line -net or -netdev options are specified. There
     * are two cases that we would otherwise complain about:
     * (1) board doesn't support a NIC but the implicit "-net nic"
     * requested one
     * (2) CONFIG_SLIRP not set, in which case the implicit "-net nic"
     * sets up a nic that isn't connected to anything.
     */
    if (!default_net) {
        net_check_clients();
    }

   Is it a good idea to split the logic between net_check_clients() and
   its caller?

> Negates to: Print the message if !qtest_enabled || nd_table[0].used.
>
>>> +        QTAILQ_FOREACH(nc, &net_clients, next) {
>>> +            if (!nc->peer) {
>>> +                warn_report("%s %s has no peer",
>>> +                            nc->info->type == NET_CLIENT_DRIVER_NIC
>>> +                            ? "nic" : "netdev", nc->name);
>>> +            }
>>>          }
>>>      }
>
>  Thomas
