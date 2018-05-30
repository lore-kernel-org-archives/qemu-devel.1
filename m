Received: from eggs.gnu.org ([2001:4830:134:3::10]:55836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fO3Tn-00088y-Rp
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fO3Tk-0007CZ-P5
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:57:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50260 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fO3Tk-0007CK-JU
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:57:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20D20BB424
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 15:57:36 +0000 (UTC)
References: <1527693912-32378-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af34cabc-9980-3f8c-c6c6-bb834c802235@redhat.com>
Date: Wed, 30 May 2018 10:57:35 -0500
MIME-Version: 1.0
In-Reply-To: <1527693912-32378-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] Add a blog post about the new
 -nic parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>

On 05/30/2018 10:25 AM, Thomas Huth wrote:
> QEMU v2.12 features a new, useful parameter called "-nic". Let's
> throw some light on this new parameter with a new blog post.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

>  screenshots/2018-05-30-qemu-cli-net.png    | Bin 0 -> 24020 bytes
>  screenshots/2018-05-30-qemu-cli-netdev.png | Bin 0 -> 13553 bytes

While binaries are necessary for use from within the blog, do you also 
have source files that can be opened under gimp or other software for 
easily tweaking the images?

> +
> +Based on this, it is already possible to define the most obvious difference
> +between `-net`, `-netdev` and `-nic`: The `-net` option can create _either_
> +a front-end or a back-end (and also does other things); `-netdev` can only
> +create a back-end; while a single occurrence of `-nic` will create _both_ a
> +front-end and a back-end. But for the non-obvious differences, we also need
> +to have a detailed look at the `-net` and `-netdev` option first ...

s/option/options/

> +
> +The legacy -net option
> +----------------------
> +
> +QEMU's initial way of configuring the network for the guest was the `-net`
> +option. The emulated NIC hardware can be chosen with the
> +`-net nic,model=xyz,...` parameter, and the host back-end with the
> +`-net <backend>,...` parameter (e.g. `-net user` for the SLIRP back-end).
> +However, the emulated NIC and the host back-end are not directly connected
> +here, but via an emulated hub (called "vlan" in older versions of QEMU), so

Does it help to be a bit more verbose in the parenthetical:

(called "vlan" in older versions of QEMU, although it has no relation to 
VLAN in IEEE 802.1Q)

> +if you start QEMU with `-net nic,model=e1000 -net user -net nic,model=virtio
> +-net tap` for example, you get a setup where all the front-ends and back-ends
> +are connected together via a hub:
> +
> +![Networking with -net](/screenshots/2018-05-30-qemu-cli-net.png)
> +
> +That means the e1000 NIC also gets the network traffic from the virtio-net
> +NIC and both host back-ends... this is probably not what the users expected;
> +it's more likely that they wanted two separate networks in the guest, one
> +for each NIC.
> +Because `-net` always connects its NIC to a hub, you would have to tell

Do you need a blank line to force a paragraph break?

> +QEMU to use _two separate hubs_, using the "vlan" parameter. For example
> +`-net nic,model=e1000,vlan=0 -net user,vlan=0 -net nic,model=virtio,vlan=1
> +-net tap,vlan=1` moves the virtio-net NIC and the "tap" back-end to a second
> +hub (with ID #1).
> +
> +Please note that the "vlan" parameter will be dropped in QEMU v3.0 since the term
> +was rather [confusing](https://bugs.launchpad.net/qemu/+bug/658904) (it's not
> +related to IEEE 802.1Q for example) and caused a lot of misconfigurations in
> +the past. Additional hubs can still be instantiated with `-netdev` (or `-nic`)
> +and the special "hubport" back-end. The `-net` option itself will still stay
> +around since it is still useful if you only want to use one front-end and
> +one back-end together, or if you want to tunnel the traffic of multiple
> +NICs through one back-end only (something like `-net nic,model=e1000
> +-net nic,model=virtio -net l2tpv3,...` for example).

Oh, so you did expand on the "vlan" term being confusing.

> +
> +
> +The modern -netdev option
> +-------------------------
> +
> +Beside the confusing "vlan" parameter of the `-net` option, there is one more
> +major drawback with `-net`: The emulated hub between the NIC and the
> +back-end gets in the way when the NIC front-end has to work closely together
> +with the host back-end. For example, vhost acceleration can not be enabled

s/can not/cannot/

> +if you create a virtio-net device with `-net nic,model=virtio`.
> +
> +To configure a network connection where the emulated NIC is directly connected
> +to a host network back-end, without a hub in between, you should use the
> +`-netdev` option for the back-end, together with `-device` for the front-end.
> +Assuming that you want to configure the same devices as in the `-net` example
> +above, you could use `-netdev user,id=n1 -device e1000,netdev=n1 -netdev
> +tap,id=n2 -device virtio-net,netdev=n2` for example. This will give you
> +straight 1:1 connections between the NICs and the host back-ends:
> +
> +![Networking with -netdev](/screenshots/2018-05-30-qemu-cli-netdev.png)
> +
> +Note that you can also still connect the devices to a hub with the special
> +`-netdev hubport` back-end, but in most of the normal use cases, the use
> +of a hub is not required anymore.
> +
> +Now while `-netdev` together with `-device` provide a very flexible and
> +extensive way to configure a network connection, there are still two
> +drawbacks with this option pair which prevented us from deprecating the
> +legacy `-net` option completely:
> +
> +1. The `-device` option can only be used for pluggable NICs. Boards
> +(e.g. embedded boards) which feature an on-board NIC can not be configured
> +with `-device` yet, so `-net nic,netdev=<id>` must be used here instead.
> +
> +2. In some cases, the `-net` option is easier to use (less to type).
> +For example, assuming you want to set up a "tap" network connection and
> +you've got the default scripts /etc/qemu-ifup and -down already in place,

s/you've got the/your/
s/already/are already/

> +it's enough to type `-net nic -net tap` to start your guest. To do the
> +same with `-netdev`, you always got to specify an ID here, too, for

s/got/have/

> +example like this: `-netdev tap,id=n1 -device e1000,netdev=n1`.
> +
> +The new -nic option
> +-------------------
> +
> +Looking at the disadvantages listed above, it should be clear that there
> +is a need for a convenience option that is
> +
> + * easier to use (i.e. less to type) than `-netdev <backend>,id=<id>
> +  -device <dev>,netdev=<id>`

a convenience option that:

* is easier...

> + * can be used to configure on-board / non-pluggable NICs, too
> + * does not place a hub between the NIC and the host back-end.
> +
> +This is where the new `-nic` option kicks in: This option can be used

s/This option/this option/

> +to configure both the guest's NIC hardware and the host back-end in
> +one go. For example, instead of `-netdev tap,id=n1 -device e1000,netdev=n1`
> +you can simply type `-nic tap,model=e1000`. If you don't care about the
> +exact NIC model type, you can even omit the `model=...` parameter and type
> +`-nic tap`. This is even shorter and more convenient than the previous
> +shortest way of typing `-net nic -net tap`. To get a list of NIC models
> +that you can use with this option, you can simply run QEMU with
> +`-nic model=help`.
> +
> +Beside being easier to use, the `-nic` option can be used to configure
> +on-board NICs, too (just like the `-net` option). For machines that have
> +on-board NICs, the first `-nic` option configures the first on-board NIC,
> +the second `-nic` option configures the second on-board NIC, and so forth.
> +
> +Conclusion
> +----------
> +
> + * The new `-nic` option gives you an easy and quick way to configure
> +   the networking of your guest.
> + * For more detailed configuration, e.g. when you need to tweak the details
> +   of the emulated NIC hardware, you can use `-device` together with `-netdev`.
> + * The `-net` option should rather be avoided these days unless you really

s/rather //

> +   want to configure a set-up with a hub between the front-ends and back-ends.
> +
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
