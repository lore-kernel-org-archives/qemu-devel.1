Received: from eggs.gnu.org ([2001:4830:134:3::10]:60988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gL6uN-00017E-WA
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gL6uK-0008T3-OL
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:33:11 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gL6uK-0008Rr-JM
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:33:08 -0500
Received: by mail-oi1-x242.google.com with SMTP id v198-v6so1459698oif.2
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 05:33:08 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181108141944.15769-1-minyard@acm.org>
	<20181108232211.GB26872@umbus.fritz.box>
From: Corey Minyard <minyard@acm.org>
Message-ID: <8a03cead-db46-f4fb-1e57-30bec0802bc8@acm.org>
Date: Fri, 9 Nov 2018 07:33:03 -0600
MIME-Version: 1.0
In-Reply-To: <20181108232211.GB26872@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH 0/2] ipmi: Allow UUID to be set for a BMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 11/8/18 5:22 PM, David Gibson wrote:
> On Thu, Nov 08, 2018 at 08:19:42AM -0600, minyard@acm.org wrote:
>> The code was using the qemu UUID for the BMC.  But that's really
>> not a good method.  In general, you don't want the GUID to change
>> when you migrate, and you want the GUID to be the same between
>> invocations of qemu (if you have a GUID).
> Hrm.  Generally the qemu UUID should remain the same across a
> migration too, and I think that will be the case if using libvirt.
> Maybe not if running qemu by hand and not specifying the uuid on the
> command line.
>
> I don't really have an objection to allowing the BMC's id to be
> explicitly controlled, but the rationale above seems a bit
> disingenuous.


I'm not sure about migration.  I suppose it could be migrated, but I
would consider the BMC part of the hardware that needs to be the
same on both sides.  It's a fuzzy line, I suppose.  The qemu UUID
is migrated, so I suppose that's not an issue.

Controlling it explicitly is important for some testing I do, and might
be for other people at some point in time, if you are trying to
emulate something specific.  And when re-invoking qemu, you
might want to keep it the same to avoid confusing software.

The big question for you is the lack of a GUID if it's not supplied.
With this change, the get GUID command will return a "command
not supported" error if the GUID is not supplied.

Thanks,

-corey

>> Plus, if you have multiple BMCs, they need to have different
>> GUIDs or the host code cannot tell them apart.  I'm not sure
>> anyone really uses multiple BMCs, but I do a lot of testing
>> with that scenario.
>>
>> This change lets the user set the GUID on the command line, and
>> if the GUID is not set return an error for the GUID fetch command.
>> This maps better to how IPMI should work.
>>
>> This change relies on the UUID being set to all zeros to know that
>> it is not set.  This is not optimal, perhaps, but an all zero
>> UUID isn't valid (it's the Nil UUID), so it should be ok.
