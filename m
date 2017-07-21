Received: from eggs.gnu.org ([2001:4830:134:3::10]:53424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYYYy-0001Lj-OJ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYYYv-0006BR-HX
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:05:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dYYYv-0006A5-8H
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:05:49 -0400
References: <1500468850-15571-1-git-send-email-thuth@redhat.com>
	<1500468850-15571-6-git-send-email-thuth@redhat.com>
	<2d593bd0-0019-77bf-d709-a107a29b7488@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4ba28b5a-4934-b9bd-4201-8ca1439729e1@redhat.com>
Date: Fri, 21 Jul 2017 16:05:45 +0200
MIME-Version: 1.0
In-Reply-To: <2d593bd0-0019-77bf-d709-a107a29b7488@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/5] target/s390x: Add remaining switches
 to compile with --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 19.07.2017 20:13, Richard Henderson wrote:
> On 07/19/2017 02:54 AM, Thomas Huth wrote:
>>       cc->has_work =3D s390_cpu_has_work;
>> +#ifdef CONFIG_TCG
>>       cc->do_interrupt =3D s390_cpu_do_interrupt;
>> +#endif
>>       cc->dump_state =3D s390_cpu_dump_state;
>>       cc->set_pc =3D s390_cpu_set_pc;
>>       cc->gdb_read_register =3D s390_cpu_gdb_read_register;
>> @@ -428,10 +430,12 @@ static void s390_cpu_class_init(ObjectClass *oc,
>> void *data)
>>       cc->get_phys_page_debug =3D s390_cpu_get_phys_page_debug;
>>       cc->vmsd =3D &vmstate_s390_cpu;
>>       cc->write_elf64_note =3D s390_cpu_write_elf64_note;
>> +#ifdef CONFIG_TCG
>>       cc->cpu_exec_interrupt =3D s390_cpu_exec_interrupt;
>>       cc->debug_excp_handler =3D s390x_cpu_debug_excp_handler;
>>       cc->do_unaligned_access =3D s390x_cpu_do_unaligned_access;
>>   #endif
>> +#endif
>=20
> These ought to be if (tcg_enabled()), surely.

I've tried that, but it does not work: s390_cpu_class_init() is called
before tcg_exec_init() (where tcg_allowed is initialized). So
tcg_enabled() always returns 0 here. ... so I guess I better keep the
patch in the current shape, especially since x86 is doing it this way,
too: http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D79c664f6

 Thomas
