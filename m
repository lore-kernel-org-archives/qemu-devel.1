Received: from eggs.gnu.org ([2001:4830:134:3::10]:37445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xro-0007dc-PT
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xrk-0006Lf-0b
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:59:32 -0400
Received: from mail.ispras.ru ([83.149.199.45]:49936)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xrj-0006Kf-Pc
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:59:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 24 Oct 2017 14:59:26 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
In-Reply-To: <CABdb736jggKYaECMnY7rORADeGexOfH3fEeCd87ZzaaMVSfC8Q@mail.gmail.com>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642407781.3900.3667954520393080307.stgit@Misha-PC.lan02.inno>
	<CABdb736jggKYaECMnY7rORADeGexOfH3fEeCd87ZzaaMVSfC8Q@mail.gmail.com>
Message-ID: <1bad3fc5b87c1b8913e010ad0d0816cd@ispras.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 41/43] windbg: implemented
 kd_api_search_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-10-03 16:58:
> On Tue, Sep 26, 2017 at 1:07 PM, Mihail Abakumov
> <mikhail.abakumov@ispras.ru> wrote:
>> +
>> +    uint8_t mem[s_len - 1 + p_len];
>=20
> s_len could be very large, people do things like
>=20
> 0:000> s -d 0x80000000 L?0x7fffffff <pattern>
>=20
> You should not allocate this buffer on the stack and preferably break
> large searches down to smaller ranges, i.e. don't allocate and read
> ~s_len bytes all at once.

Yes, you're right. I corrected it.

>=20
>> +    int err =3D cpu_memory_rw_debug(cpu, addr, mem, sizeof(mem), 0);
>> +    if (!err) {
>> +        int i;
>> +        pd->m64.ReturnStatus =3D STATUS_NO_MORE_ENTRIES;
>> +        for (i =3D 0; i < s_len; ++i) {
>> +            if (memcmp(mem + i, pd->extra, p_len) =3D=3D 0) {
>> +                m64c->FoundAddress =3D addr + i;
>> +                m64c->FoundAddress =3D ldq_p(&m64c->FoundAddress);
>> +                pd->m64.ReturnStatus =3D STATUS_SUCCESS;
>> +                break;
>> +            }
>> +        }
>=20
> Use memmem instead?
>=20

For some reason, I do not have such function.

Thanks,
Mihail Abakumov
