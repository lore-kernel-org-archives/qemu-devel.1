Received: from eggs.gnu.org ([2001:4830:134:3::10]:51581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqiCH-0006o1-ML
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqiCD-0003bg-JZ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:29:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cqiCD-0003bX-Bd
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:29:09 -0400
References: <cover.1489494746.git.janne.huttunen@nokia.com>
	<1489510640.8844.18.camel@redhat.com>
	<1489561105.24841.25.camel@nokia.com>
	<11a3eab4-77f8-87ea-9558-299fbfc77a07@redhat.com>
	<1490164614.19055.31.camel@nokia.com>
	<1558854179.6445757.1490172190685.JavaMail.zimbra@redhat.com>
	<1490173225.19055.48.camel@nokia.com>
	<c1a80bf6-1379-8402-06d4-01247825fcf0@redhat.com>
	<1490191138.19055.92.camel@nokia.com>
	<8616b7ec-8306-25b4-267c-449f94261502@redhat.com>
	<1490195960.19055.105.camel@nokia.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3229b3f8-7689-94d1-05a8-8b8c34bc0d25@redhat.com>
Date: Wed, 22 Mar 2017 16:29:03 +0100
MIME-Version: 1.0
In-Reply-To: <1490195960.19055.105.camel@nokia.com>
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

On 03/22/17 16:19, Janne Huttunen wrote:
> On Wed, 2017-03-22 at 15:36 +0100, Laszlo Ersek wrote:
>>  
>> To my knowledge, currently the bootindex properties cannot be changed
>> dynamically (for example with monitor commands) after they have been
>> specified on the QEMU command line.
> 
> Yes they can, via QMP:
> 
> {'execute': 'qom-get', 'arguments': { 'path': 'scsi0.0/child[0]',
> 'property': 'bootindex' }}
> {"return": 10}
> 
> {'execute': 'qom-set', 'arguments': { 'path': 'scsi0.0/child[0]',
> 'property': 'bootindex', 'value': 11 }}
> {"return": {}}
> 
> {'execute': 'qom-get', 'arguments': { 'path': 'scsi0.0/child[0]',
> 'property': 'bootindex' }}
> {"return": 11}
> 
> 
> I have no idea if doing so breaks something, like e.g.
> migration, but it definitely can be done.
> 
>> And, even if some settings can be changed, the question is what agent
>> changes them. If the management layer (libvirt etc) changes them
>> using
>> monitor commands, then libvirt itself can keep track of that state,
>> and
>> then start the QEMU process on the destination  host with a suitably
>> modified command line.
>>
>> Whereas, if it is the guest that changes device state, memory state
>> etc,
>> then those things have to be part of the migration stream.
> 
> True.
> 
>>> If it
>>> is, migrating the "bootonceindex" values the same way should
>>> be sufficient, no?
>> To my knowledge, "bootindex" properties are not migrated now, and
>> they
>> also need not to, because they never change at runtime.
> 
> Like demonstrated above, they can change, but of course
> there might be an assumption that they won't change
> "unexpectedly".
> 
>> If the second system sets a temporary boot order for the first system
>> "every now and then", which I guess entails on-demand talking to the
>> first system's management processor, then how can you replace that
>> with
>> a static QEMU command line (with the proposed bootonceindex
>> property)?
> 
> I'm not. I'm using QMP to change the index dynamically.

Wait, if you are already changing the "bootindex" property dynamically
(do I understand that right?), and it even takes effect after guest
reboot, then why is "bootonceindex" necessary at all?

(I apologize, I think I'm confused.)

Thanks
Laszlo

> 
>> I'm not saying that the use case is without merit. My point is that
>> this
>> new property would introduce obscure interactions with other
>> components
>> in the virt stack around QEMU, and it could have a significant
>> maintenance footprint, while the feature does look niche (to me
>> anyway).
> 
> Maybe, and it is definitely good to analyze it. Like I
> already admitted, I did not think about migration at all
> and there may very well have been other things I have
> overlooked too.
> 
> 
