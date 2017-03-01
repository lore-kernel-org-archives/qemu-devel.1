Received: from eggs.gnu.org ([2001:4830:134:3::10]:48519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cjAk3-0004r7-Ok
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cjAk2-00023d-3T
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:20:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cjAk1-00023U-R9
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:20:54 -0500
References: <41cc9d11-2e28-5b5e-4772-81a118d79111@redhat.com>
	<20170227101817.11748-1-mmarek@suse.com>
	<41e6edc0-204b-62b7-93b8-b376a40542d6@twiddle.net>
	<bf246870-6e7c-f540-7cd4-3a20d5912162@redhat.com>
	<ea3392d8-cd07-64e0-134a-4f111fe853db@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0ac325ae-6b68-2a03-74a8-c5ab0ebb58e0@redhat.com>
Date: Wed, 1 Mar 2017 21:20:50 +0100
MIME-Version: 1.0
In-Reply-To: <ea3392d8-cd07-64e0-134a-4f111fe853db@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Michal Marek <mmarek@suse.com>, Alexander Graf <agraf@suse.de>
Cc: Eric Bischoff <ebischoff@suse.com>, Miroslav Benes <mbenes@suse.cz>, qemu-devel@nongnu.org

On 01.03.2017 20:30, Richard Henderson wrote:
> On 03/01/2017 07:00 PM, Thomas Huth wrote:
>>> Primarily, it does not raise an exception for error.
>>
>> Protection and page faults should be generated properly via
>> trigger_access_exception() there ... or did I miss something?
>=20
> So why does s390_cpu_virt_mem_rw document that it returns non-zero if
> there was an error?

The non-zero return code is needed for the callers to decide whether to
continue or not (this is used in non-TCG code, too, so we need something
that is independent from TCG magic here). See the usage of
s390_cpu_virt_mem_read() / ..._write() in target/s390x/ioinst.c for examp=
le.

> I see you do raise an exception on the TCG path (via translate_pages),
> but not the KVM path.  That is very confusing.

The KVM_S390_MEM_OP ioctl can raise an exception, too. I konw, it's
confusing, but that ioctl was necessary since you need to hold a special
lock in KVM while walking the page tables.

>> AR =3D Access Register ... they are needed when the CPU runs in access
>> register mode (i.e. the AS PSW bits are 01). AFAIK we don't emulate th=
is
>> in QEMU yet, but the KVM_S390_MEM_OP ioctl already supports it.
>=20
> Hmm.  I guess I don't know how to read that then.

The access-register mode is described in the "Access-Register
Translation" sub-chapter in Chapter 5 ("Program Execution") of the POP.
Make sure to have some good painkillers ready first, though ... that's
IMHO really one of the ugliest parts of the architecture ;-)

>>> Your writes need to look a lot more like fast_memmove in mem_helper.c=
,
>>> except that of course only the destination needs translation.
>>
>> I still think that s390_cpu_virt_mem_write() should be fine here, too.
>=20
> Ideally you'd interact with the TCG TLB in some way so that you didn't
> have to manage your own translation and your own exceptions.  That's
> what fast_memmove does.

Well, all the code from s390_cpu_virt_mem_rw() can also run with KVM -
in case the KVM_S390_MEM_OP is not available (which also has just been
introduced two years ago). So all the code that can be called by
s390_cpu_virt_mem_rw() has to work also without TCG.

But I agree, since the original problem here (TCG emulation of stfle) is
not related to KVM, it's maybe better to use a function a la
fast_memmove there instead.

>>> Of course, in practice we could reduce this to just one cpu_stl_data =
for
>>> STFL and one or two cpu_stq_data for STFLE.
>>
>> I think STFLE can store more than two 64-bit words, can't it?
>=20
> Technically, yes.  But there are less than 128 bits defined.  Certainly
> much less than the 4k bits that Michal prepares for.

True. But maybe we should then also have an assert() or something
similar here in case the bits exceed the 128 limit one day...?

 Thomas
