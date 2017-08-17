Received: from eggs.gnu.org ([2001:4830:134:3::10]:50323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diOBT-0007jX-76
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 13:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diOBO-0005T2-CD
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 13:02:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1diOBO-0005SH-68
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 13:02:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
	<2897c32f34b415aadcf43a5ae296cf5f6e15e757.1501280035.git.alistair.francis@xilinx.com>
	<87valqw9x0.fsf@dusky.pond.sub.org>
	<CAKmqyKPA6v3RpZAFOibfNeOZVzai5phfXo2njDkD6PxsBgqVrw@mail.gmail.com>
	<87lgmluw2g.fsf@dusky.pond.sub.org>
	<ab184e25-19f5-5fd2-494a-7ea04e48f6c7@redhat.com>
Date: Thu, 17 Aug 2017 19:02:06 +0200
In-Reply-To: <ab184e25-19f5-5fd2-494a-7ea04e48f6c7@redhat.com> (Paolo
	Bonzini's message of "Thu, 17 Aug 2017 16:35:34 +0200")
Message-ID: <87fucq86wh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 5/5] Convert single line fprintf() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 15/08/2017 09:30, Markus Armbruster wrote:
>> The stupid fix is to repeat libraries until the link succeeds:
>> 
>>     test-util-obj-y = libqemuutil.a libqemustub.a libqemuutil.a
>> 
>> You may have seen this with -lX11 if you're old enough.
>> 
>> ld(1) suggests the linker can do it for us:
>> 
>>     -( archives -)
>>     --start-group archives --end-group
>>         The archives should be a list of archive files.  They may be either
>>         explicit file names, or -l options.
>> 
>>         The specified archives are searched repeatedly until no new
>>         undefined references are created.  Normally, an archive is searched
>>         only once in the order that it is specified on the command line.
>>         If a symbol in that archive is needed to resolve an undefined
>>         symbol referred to by an object in an archive that appears later on
>>         the command line, the linker would not be able to resolve that
>>         reference.  By grouping the archives, they all be searched
>>         repeatedly until all possible references are resolved.
>> 
>>         Using this option has a significant performance cost.  It is best
>>         to use it only when there are unavoidable circular references
>>         between two or more archives.
>> 
>> Sticking '-Wp,-(' and '-Wp,-)' into the command line I get from make V=1
>> doesn't work for me, though.
>> 
>> The smart solution is not to have .a reference each other.
>
> Nah, I think we should teach those new kids on the block about -lX11
> instead. :)
>
>> Paolo, what do you think?
>
> Another possibility is to just merge the two static libraries into one.

Sounds good to me!
