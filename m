Received: from eggs.gnu.org ([2001:4830:134:3::10]:51913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqdrh-0000VI-72
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqdrd-0007y8-VZ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:51:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cqdrd-0007xS-MU
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:51:37 -0400
References: <cover.1489494746.git.janne.huttunen@nokia.com>
	<1489510640.8844.18.camel@redhat.com>
	<1489561105.24841.25.camel@nokia.com>
	<11a3eab4-77f8-87ea-9558-299fbfc77a07@redhat.com>
	<1490164614.19055.31.camel@nokia.com>
	<1558854179.6445757.1490172190685.JavaMail.zimbra@redhat.com>
	<1490173225.19055.48.camel@nokia.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c1a80bf6-1379-8402-06d4-01247825fcf0@redhat.com>
Date: Wed, 22 Mar 2017 11:51:32 +0100
MIME-Version: 1.0
In-Reply-To: <1490173225.19055.48.camel@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC][PATCH 0/6] "bootonceindex" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Huttunen, Janne (Nokia - FI/Espoo)" <janne.huttunen@nokia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 03/22/17 10:00, Huttunen, Janne (Nokia - FI/Espoo) wrote:
> On Wed, 2017-03-22 at 04:43 -0400, Paolo Bonzini wrote:
>>
>> Understood---my question is how you would set up the alternate
>> boot order: is it something like "keep a button pressed while
>> turning on", or something written in NVRAM, or something else
>> that is completely different?
> 
> In my case the real hardware has a management processor
> on the board and the temporary boot source (and also the
> permanent one for that matter) for the main processor can
> be set from there. Since neither the BIOS nor the management
> firmware are open source, I don't know how it technically
> works, but I assume there either is some shared memory
> between the main BIOS and the management processor or
> alternatively the BIOS talks with the management processor
> with some protocol during boot to get the order.
> 

I'm generally opposed to the proposed implementation for this feature /
use case; that is, the new "bootonceindex" device property.

(1) My somewhat hand-waving counter-argument is simply the complexity /
confusion that it introduces. See for example recent QEMU commit
c0d9f7d0bced ("docs: Add a note about mixing bootindex with "-boot
order"", 2017-02-28).

Even if the proposed solution keeps the "bootorder" fw_cfg file intact,
and firmware wouldn't have to look at other fw_cfg files -- I can
already guarantee that OVMF will not look at other fw_cfg files --, the
command line changes look undesirable to me.

(2) My more technical counter-arguments are:

(2a) Exposing this in the libvirt domain XML would be a huge pain.
AFAICS, libvirt already doesn't expose "-boot once" in the domain XML,
which is a *good* thing.

(2b) With the proposed change, "having rebooted once" becomes explicit
runtime state that is guest-controlled. As such, it would have to be
migrated. Assume that you start the guest on the source host, using both
bootindex and bootonceindex properties. Then, for migration, libvirt (or
the user, manually) starts QEMU on the target host using the same
command line. After migration, if the guest reboots on the target host,
its behavior should depend on whether said reboot is its first reboot
since launching the domain, so the fact whether it rebooted on the
source host should reach the target host.


I think you must already have a means to massage the management
processor to change the boot order, for the next boot. Are you doing
that massaging in code that runs on the main processor? If so, that
means the "guest code" is highly privileged, as it can control outside
components in order to influence the boot order.

For that, I can offer the following analogy:

- use a guest with libvirt

- whenever you want to modify the boot order from within the guest,
  ssh back out to the host, and use virsh-dumpxml (--inactive),
  the xmlstarlet utility, and virsh-define, to dump, edit, and save the
  domain XML non-interactively. Xmlstarlet is extremely versatile for
  modifying domain XMLs (or any other kinds of XMLs), and virsh-define
  explicitly supports the case when the domain is already running.

  In a normal virtualization environment, this would be a huge security
  hole, of course, but you are already manipulating the management
  processor from code that runs on the main processor. Exact same
  privilege escalation.

- whenever you want to relaunch the domain fully (i.e., restart QEMU
  with a new command line), again ssh out to the host, and start a
  process (a shell script) in the background. The script should first
  initiate a domain shutdown (virsh-shutdown), then wait for domain
  termination (virsh-qemu-monitor-event, and see the SHUTDOWN event in
  "qapi/event.json"), then start the domain (virsh start). Which is
  when the modified boot order will take effect.


Alternatively, if you are fine using OVMF (as UEFI firmware) within the
guest, to run your payload, you can try the following commands, to set
the BootNext UEFI variable & to reboot:

  efibootmgr --bootnext XXXX
  reboot

While OVMF heavily massages the UEFI boot order (based on the
"bootorder" fw_cfg file), *if* you stick with a constant set of
bootindex properties (== constant boot order setting in the libvirt
domain XML), then most of the UEFI BootXXXX variables that you get to
see in the guest *should* be stable, and the above commands should
hopefully work (no guarantees though).

Thanks
Laszlo
