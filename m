Received: from eggs.gnu.org ([2001:4830:134:3::10]:51701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fO3By-0005ET-5y
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fO3Bu-0006Eq-4l
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:39:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fO3Bt-0006EP-V0
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:39:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DAF6406F8A7
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 15:39:09 +0000 (UTC)
References: <1527682717-26391-1-git-send-email-thuth@redhat.com>
	<97633c36-0af1-45c2-f103-7bc130c4c428@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbd4057c-7887-e8ae-8e5c-a63a012cd4e2@redhat.com>
Date: Wed, 30 May 2018 10:39:08 -0500
MIME-Version: 1.0
In-Reply-To: <97633c36-0af1-45c2-f103-7bc130c4c428@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post about the new
 -nic parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

On 05/30/2018 07:54 AM, Paolo Bonzini wrote:
> On 30/05/2018 14:18, Thomas Huth wrote:
>> QEMU v2.12 features a new, useful parameter called "-nic". Let's
>> throw some light on this new parameter with a new blog post.
> 
> Nice!
> 

>> +QEMU v2.12 has a new command line parameter, the `-nic` parameter, which can
> 
> "Option" instead of parameter perhaps?  Let's reserve "parameter" for
> the key/value pairs.
> 
>> +be used to configure a network connection for the guest quite easily, since
>> +it sets up both, the guest NIC and the host network backend in one go.

s/both,/both/

>> +If you've read the
>> +[ChangeLog of QEMU v2.12](https://wiki.qemu.org/ChangeLog/2.12) or the current
>> +[documentation of QEMU](https://qemu.weilnetz.de/doc/qemu-doc.html)
>> +you might already have spotted this new `-nic` parameter, and maybe you've
>> +thought "Why yet another parameter for configuring the network?". To answer
>> +that question, we've got to have look at the basics and other options first.
> 
> I think the introduction could be improved.  Something like:
> 
> If you used QEMU in the past, you are probably familiar with the `-net`
> command line option, which can be used to configure a network connection
> for the guest.  Some of you may also be familiar with `-netdev`, which
> configures a network _backend_.  Yet, QEMU v2.12 introduces a third way
> to configure NICs, the `-nic` option.
> 
> The [ChangeLog of QEMU
> v2.12](https://wiki.qemu.org/ChangeLog/2.12#Network) says that `-nic`
> can "quickly create a network front-end (emulated NIC) and a host
> back-end".  But why did QEMU need yet another way to configure the
> network, and how does it compare with `-net` and `-netdev`?  To answer
> these questions, we need to look at the model behind network
> virtualization in QEMU.
> 
>> +To configure a network interface for a guest, you've got to consider two
>> +sides:
> 
> As hinted by the ChangeLog entry, a network interface consists of two
> separate entities:
> 
>> +1. The emulated hardware that the guest sees, i.e. the so-called NIC (network
>> +interface controller). On systems that support PCI cards, these typically
>> +could be an e1000 network card, a rtl8139 network card or a virtio-net device.
> 
> This entity is also called the "front-end"
> 
>> +
>> +2. The network backend on the host side, i.e. the interface that QEMU uses
> 
> Please standardize on either front-end/back-end, or frontend/backend.
> The squiggly red line in Thunderbird suggests that the former is more
> correct, though.
> 
>> +to exchange network packets with the outside (like other QEMU instances
>> +or other real hosts in your intranet or in the internet). The common host

s/or in the internet/or the internet/

>> +backends are the "user" (a.k.a. SLIRP) backend which provides access to
>> +the host's network via NAT, the "tap" backend which allows the guest to
>> +directly access the host's network, or the "socket" backend which can be
>> +used to connect multiple QEMU instances to simulate a shared network for
>> +the their guests.

s/the their/their/

> 
> Perhaps we can already say here:
> 
> ---
> Based on this, it is already possible to define the difference between
> `-net`, `-netdev` and `-nic`: `-net` can create _either_ a front-end or
> a back-end (and also does other things); `-netdev` can only create a
> back-end; while a single occurrence of `-nic` will create _both_ a
> front-end and a back-end.
> ---
> 
> but I'm not sure is an improvement.
> 
>> +The legacy -net option
>> +----------------------
>> +
>> +QEMU's initial way of configuring the network for the guest was the `-net`
>> +option.
> 
> If you don't say it above, you should say here "`-net` can create either
> a front-end or a back-end, depending on its argument.  `net nic,...`
> will create a front-end, while `-net _backend-type_,...` (e.g. `-net
> user` for SLIRP) will create a backend."
> 
>   The emulated NIC hardware can be chosen with the
>> +`-net nic,model=xyz,...` parameter, and the host backend with the
>> +`-net <backend>,...` parameter (e.g. `-net user` for the SLIRP backend).
>> +The emulated NIC and the host backend are not directly connected here, but
> 
> Perhaps "However" or "In addition" at the beginning of this sentence?
> 
>> +via an emulated hub (called "vlan" in QEMU), so if you start QEMU with
> 
> Not sure you should mention "vlan" here.  Perhaps only below when you
> explain the argument?
> 
> Do you want to mention the correct usage of vlan/hub here, e.g. `-net
> nic,model=e1000 -net nic,model=virtio -net user`?
> 
>> +`-net nic,model=e1000 -net user -net nic,model=virtio -net tap` for example,
>> +you get a setup where all the NICs and host backends are connected together
>> +via a hub:
>> +
>> +![Networking with -net](/screenshots/2018-05-30-qemu-cli-net.png)
>> +
>> +That means the e1000 NIC also gets the network traffic from the virtio-net
>> +NIC and both host backends... this is probably not what the user expected,
>> +who likely wanted to have two separate network connections instead.
> 
> ... "what the user expected; it's more likely that they wanted two
> separate networks in the guest, one for each NIC".
> 
>> To achieve
>> +this with the `-net` parameter, you've got to use the "vlan" option instead,
> 
> Because `-net` always connects its NIC to a hub, you would have to tell
> QEMU to use _two separate hubs_, using the "vlan" parameter, for example...
> 
> (Contractions should be avoided in written English.  So "you have to",
> "you should", etc. is preferrable to "you've got to".  That also sounds
> very informal to me, but at this point I'm going to wave my hands and
> say I'm not a native speaker).

Your rewrite without the contraction seems fine to me.

> 
>> +for example `-net nic,model=e1000,vlan=0 -net user,vlan=0
>> +-net nic,model=virtio,vlan=1 -net tap,vlan=1` moves the virtio-net NIC
>> +and the "tap" backend to another hub (with ID #1). Please note that the
>> +"vlan" option will be dropped in QEMU v3.0 since the term was rather
>> +[confusing](https://bugs.launchpad.net/qemu/+bug/658904) (it's not related
>> +to IEEE 802.1Q for example) and caused a lot of misconfigurations in the past.
> 
> In order to use multiple hubs as in this example, you will have to
> declare each hub port manually.  This will be the topic of a separate
> blog post.  (Right? :))
> 
>> +The modern -netdev option
>> +-------------------------
>> +
>> +Beside the confusing "vlan" option of the `-net` parameter, there is one
>> +more major drawback with that legacy option: Since you always get the
>> +emulated hub here inbetween to which multiple NICs and host backends could be

s/inbetween/in between/

>> +attached, you can not use this concept for situations where the NIC frontend
>> +has to work very closely together with the host backend, e.g. when you want
>> +to use vhost acceleration for virtio-net.
> 
> ... with that option: the emulated hub between the NIC and the backend
> gets in the way when the NIC front-end has to work closely together with
> the host back-end.  For example, vhost acceleration is disabled if you
> create a virtio-net device with `-net nic,model=virtio`.
> 
>> +
>> +To configure a network connection where the emulated NIC is directly connected
>> +to a host network backend without a hub inbetween,
> 
> Is "inbetween" actually an English word?  I would say "... to a host
> network back-end, without a hub in between,".
> 
>> you've got to use the
> 
> (Another occurrence of "you've got to").
> 
>> +`-netdev` option for the backend, together with `-device` for the guest NIC
>> +hardware. Assuming that you want to configure the same devices as in the
>> +`-net` example above, you could use `-netdev user,id=n1 -device e1000,netdev=n1
>> +-netdev tap,id=n2 -device virtio-net,netdev=n2` for example. This will give you

Two uses of the word 'example' in the same sentence; are both needed?

>> +straight 1:1 connections between the NICs and the host backends:
>> +
>> +![Networking with -netdev](/screenshots/2018-05-30-qemu-cli-netdev.png)
>> +
>> +Note that you can also still connect the devices to a hub with the special
>> +`-netdev hubport` backend, but in most of the normal use cases, the use
>> +of a hub is not required anymore.
>> +
>> +Now while `-netdev` together with `-device` provide a very flexible and
>> +extensive way to configure a network connection, there are still two
>> +drawbacks with this option pair which prevented us from deprecating the
>> +legacy `-net` parameter completely:
>> +
>> +1. The `-device` parameter can only be used for pluggable NICs. Boards
>> +(e.g. embedded boards) which feature an on-board NIC can not be configured
>> +with `-device` yet, so `-net nic` must be used here instead.
> 
> This is actually okay, you can use `net nic,netdev=...` IIRC.
> 
>> +2. In some cases, the `-net` parameter is easier to use (less to type).
>> +For example, assuming you want to set up a "tap" network connection and
>> +you've got the default scripts /etc/qemu-ifup and -down already in place,
>> +it's enough to type `-net nic -net tap` to start your guest. To do the
>> +same with `-netdev`, you always got to specify an ID here, too, for
>> +example like this: `-netdev tap,id=n1 -device e1000,netdev=n1`.
>> +
>> +The new -nic option
>> +-------------------
>> +
>> +Looking at the disadvantages listed above, it should be clear that there
>> +is a need for a convenience option that is
>> +
>> + * easier to use (i.e. less to type) than `-netdev <backend>,id=<id>
>> +  -device <dev>,netdev=<id>`
>> + * can be used to configure on-board / non-pluggable NICs, too
>> + * does not use a hub between the NIC and the host backend.
> 
> s/use a hub/place a hub/
> 
>> +
>> +This is where the new `-nic` option kicks in: This option can be used
> 
> If you feel the need to put an uppercase letter after a colon, it
> probably should be a period instead.
> 
>> +to configure both, the guest's NIC hardware and the host backend in
> 
> s/both,/both/ (German influence?)
> 
>> +one go. For example, instead of `-netdev tap,id=n1 -device e1000,netdev=n1`
>> +you can simply type `-nic tap,model=e1000`. If you don't care about the
>> +exact NIC model type, you can even omit the `model=...` option and type
>> +`-nic tap`. This is even shorter and more convenient than the previous
>> +shortest way of typing `-net nic -net tap`. To get a list of NIC models
>> +that you can use with this option, you can simply run QEMU with
>> +`-nic model=help`.
>> +
>> +Beside being easier to use, the `-nic` option can be used to configure
>> +on-board NICs, too (just like the `-net` option). For machines that have
>> +on-board NICs, the first `-nic` parameter configures the first on-board NIC,
>> +the second `-nic` parameter configures the second on-board NIC, and so forth.
>> +You obviously have got to omit the `model=...` option from the `-nic`
>> +parameter in this case, though (or use the right model name of the on-board
>> +NIC).
> 
> Perhaps this last paragraph can be eliminated?
> 
> Some conclusions are missing.  Maybe something about deprecation in
> general, and how we always try to improve on the usability of the
> command line when deprecating options?
> 


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
