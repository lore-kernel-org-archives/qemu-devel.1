Received: from eggs.gnu.org ([2001:4830:134:3::10]:41848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPjf0-0006Rv-9A
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 02:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPjev-00028k-B8
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 02:07:38 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:57581 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPjeu-00027f-VH
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 02:07:33 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838191990.6497.6153382313093413628.stgit@frigg.lan>
	<895e8e6e-05ef-a673-96c1-f5c231137b0a@twiddle.net>
Date: Tue, 27 Jun 2017 09:07:21 +0300
In-Reply-To: <895e8e6e-05ef-a673-96c1-f5c231137b0a@twiddle.net> (Richard
	Henderson's message of "Mon, 26 Jun 2017 19:57:48 -0700")
Message-ID: <87k23y3qw6.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 07/26] target: [tcg,
 i386] Refactor init_disas_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

Richard Henderson writes:

> On 06/25/2017 02:12 AM, Llu=C3=ADs Vilanova wrote:
>> +    DisasContext *dc =3D container_of(db, DisasContext, base);
>> CPUX86State *env =3D cpu->env_ptr;
>> -    DisasContext dc1, *dc =3D &dc1;
>> -    DisasContextBase *db =3D &dc1.base;
>> -    uint32_t flags;
>> -    target_ulong cs_base;
>> -    int num_insns;
>> -    int max_insns;
>> -
>> -    /* generate intermediate code */
>> -    db->pc_first =3D tb->pc;
>> -    cs_base =3D tb->cs_base;
>> -    flags =3D tb->flags;
>> +    uint32_t flags =3D db->tb->flags;
>> +    target_ulong cs_base =3D db->tb->cs_base;

> As a nit, it would be better for the compiler if you keep only one of the=
 two
> pointers {dc,db} live.  That is, once you've used container_of, always use
> dc-> base instead of db.

That's what the previous version did, but Emilio proposed to use both to ke=
ep
diffs more readable.

Still, if using both dc/db will confuse the compiler's alias analysis, I can
revert it back to dc->base.

Thanks,
  Lluis
