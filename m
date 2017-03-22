Received: from eggs.gnu.org ([2001:4830:134:3::10]:36026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqhNo-0007ib-E4
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqhNk-0006GT-EH
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:37:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cqhNk-0006GO-5M
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:37:00 -0400
References: <cover.1489494746.git.janne.huttunen@nokia.com>
	<1489510640.8844.18.camel@redhat.com>
	<1489561105.24841.25.camel@nokia.com>
	<11a3eab4-77f8-87ea-9558-299fbfc77a07@redhat.com>
	<1490164614.19055.31.camel@nokia.com>
	<1558854179.6445757.1490172190685.JavaMail.zimbra@redhat.com>
	<1490173225.19055.48.camel@nokia.com>
	<c1a80bf6-1379-8402-06d4-01247825fcf0@redhat.com>
	<1490191138.19055.92.camel@nokia.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8616b7ec-8306-25b4-267c-449f94261502@redhat.com>
Date: Wed, 22 Mar 2017 15:36:49 +0100
MIME-Version: 1.0
In-Reply-To: <1490191138.19055.92.camel@nokia.com>
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
To: Janne Huttunen <janne.huttunen@nokia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 03/22/17 14:58, Janne Huttunen wrote:
> On Wed, 2017-03-22 at 11:51 +0100, Laszlo Ersek wrote:
>>  
>> I'm generally opposed to the proposed implementation for this feature
>> /
>> use case; that is, the new "bootonceindex" device property.
>>
>> (1) My somewhat hand-waving counter-argument is simply the complexity
>> /
>> confusion that it introduces. See for example recent QEMU commit
>> c0d9f7d0bced ("docs: Add a note about mixing bootindex with "-boot
>> order"", 2017-02-28).
> 
> I agree that it may be confusing, but I was under the
> (possibly false?) impression that the "-boot order" was on
> its way to being deprecated. I thought supporting the same
> functionality on "bootindex" -based configuration would
> actually _help_ eventually getting rid of "-boot order".
> 
> Of course it can be argued that the "-boot once" was
> always a misfeature and should be removed at the same time,

Yes, that's my argument.

> but as it stands I find it even more confusing that there
> exists this "bootindex" mechanism but "-boot once" isn't
> compatible with it and no compatible alternative seems to
> exist at all.

All of the "-boot" options have guest architecture and firmware-specific
behavior (they are even documented so, in both the libvirt domain XML
docs and the QEMU manual page).

For example, "-boot order" is translated to x86 CMOS settings that are
unusable in any firmware that isn't "legacy x86 BIOS".

> 
>> Even if the proposed solution keeps the "bootorder" fw_cfg file 
>> intact, and firmware wouldn't have to look at other fw_cfg files --
>> I can already guarantee that OVMF will not look at other fw_cfg
>> files --, the command line changes look undesirable to me.
> 
> The current implementation doesn't require any firmware
> changes.
> 
>> (2) My more technical counter-arguments are:
>>
>> (2a) Exposing this in the libvirt domain XML would be a huge pain. 
>> AFAICS, libvirt already doesn't expose "-boot once" in the domain 
>> XML, which is a *good* thing.
> 
> I'm nowhere nearly qualified to comment on that so I'll leave
> it to others.
> 
>> (2b) With the proposed change, "having rebooted once" becomes 
>> explicit runtime state that is guest-controlled. As such, it would
>> have to be migrated. Assume that you start the guest on the source
>> host, using both bootindex and bootonceindex properties. Then, for
>> migration, libvirt (or the user, manually) starts QEMU on the
>> target host using the same command line. After migration, if the
>> guest reboots on the target host, its behavior should depend on
>> whether said reboot is its first reboot since launching the domain,
>> so the fact whether it rebooted on the source host should reach the
>> target host.
> 
> Whether the first boot has happened or not is reflected in
> the values of the "bootonceindex" properties. The current
> implementation resets them back to -1 when the boot happens.
> I'm not qualified to say if that is sufficient or not, but
> if it isn't don't you already have problems migrating other
> things? If e.g. someone sets the "bootindex" property while
> the system is running, is that going to get migrated?

To my knowledge, currently the bootindex properties cannot be changed
dynamically (for example with monitor commands) after they have been
specified on the QEMU command line.

And, even if some settings can be changed, the question is what agent
changes them. If the management layer (libvirt etc) changes them using
monitor commands, then libvirt itself can keep track of that state, and
then start the QEMU process on the destination  host with a suitably
modified command line.

Whereas, if it is the guest that changes device state, memory state etc,
then those things have to be part of the migration stream.

> If it
> is, migrating the "bootonceindex" values the same way should
> be sufficient, no?

To my knowledge, "bootindex" properties are not migrated now, and they
also need not to, because they never change at runtime.

> You can probably tell that I'm not very familiar with the
> migration and I must admit that I did not think about it
> at all when doing the implementation, but things like this
> are exactly the reason I wanted to get comments on the idea.
> 
>> I think you must already have a means to massage the management
>> processor to change the boot order, for the next boot. Are you doing
>> that massaging in code that runs on the main processor?
> 
> No, the changes are made externally. My setup is such that
> first there is a computer that has a main processor with
> an attached management processor. Then there is a second
> external system that remotely monitors and controls the
> first one. Part of what the second system does requires
> setting a temporary boot order for the next reboot of the
> first system every now and then.

How does this work in more detail?

If the second system sets a temporary boot order for the first system
"every now and then", which I guess entails on-demand talking to the
first system's management processor, then how can you replace that with
a static QEMU command line (with the proposed bootonceindex property)?

It suggests that you are able to start QEMU processes on demand, if for
nothing else then to set the bootonceindex properties.

> Many of the used components
> are beyond my control (like e.g. operating systems etc.)
> meaning that I either cannot modify them or doing so would
> make the whole exercise moot. All this exists in real
> hardware, but since there's never enough hardware available
> and there are better uses for it, I tried to set up a virtual
> machine that could act as a cheap substitute.

I'm not saying that the use case is without merit. My point is that this
new property would introduce obscure interactions with other components
in the virt stack around QEMU, and it could have a significant
maintenance footprint, while the feature does look niche (to me anyway).
If there is another way to achieve what you need, possibly using other
tools as well, I suggest that we research that more (which is why we
keep inquiring about your setup I guess).

Thanks
Laszlo
