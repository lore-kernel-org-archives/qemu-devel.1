Received: from eggs.gnu.org ([2001:4830:134:3::10]:41819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6yAM-0005Yi-Ey
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6yAJ-0005b5-9L
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:18:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6yAJ-0005Zu-3A
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:18:39 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1508838503.3135.12.camel@intel.com> (Amarnath Valluri's message
	of "Tue, 24 Oct 2017 09:47:46 +0000")
References: <20171024063550.22441-1-quintela@redhat.com>
	<1508838503.3135.12.camel@intel.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Oct 2017 14:18:31 +0200
Message-ID: <87she891t4.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] tpm: Fix compilation with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Valluri, Amarnath" <amarnath.valluri@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, "lvivier@redhat.com" <lvivier@redhat.com>

"Valluri, Amarnath" <amarnath.valluri@intel.com> wrote:
> On Tue, 2017-10-24 at 08:35 +0200, Juan Quintela wrote:
>> Commit
>> =C2=A0=C2=A0=C2=A0c37cacabf2285b0731b44c1f667781fdd4f2b658
>>=20
>> broke compilation without tpm.=C2=A0=C2=A0Just add an #ifdef
>>=20
>> CC: Amarnath Valluri <amarnath.valluri@intel.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>> =C2=A0tpm.c | 6 +++++-
>> =C2=A0vl.c=C2=A0=C2=A0| 2 ++
>> =C2=A02 files changed, 7 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tpm.c b/tpm.c
>> index 45520f555d..e2f3be2e08 100644
>> --- a/tpm.c
>> +++ b/tpm.c
>> @@ -223,8 +223,11 @@ TPMInfoList *qmp_query_tpm(Error **errp)
>> =C2=A0
>> =C2=A0TpmTypeList *qmp_query_tpm_types(Error **errp)
>> =C2=A0{
>> +=C2=A0=C2=A0=C2=A0=C2=A0TpmTypeList *head =3D NULL;
>> +
>> +#ifdef CONFIG_TPM
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int i =3D 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0TpmTypeList *head =3D NULL, *prev =3D NULL, *cu=
r_item;
>> +=C2=A0=C2=A0=C2=A0=C2=A0TpmTypeList *prev =3D NULL, *cur_item;
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < TPM_TYPE__MAX; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!tpm_be_find_b=
y_type(i)) {
>> @@ -241,6 +244,7 @@ TpmTypeList *qmp_query_tpm_types(Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prev =3D cur_item;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> +#endif
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return head;
>> =C2=A0}
> I would prefer to bring everything in tpm.c under #ifdef CONFIG_TPM.
> and provide dummy implementations only for qmp commands:
> qmp_query_{tpm,_models,_types} in disable-tpm case.

Hi

We can't compile out tpm.c in case of disable CONFIG_TPM, but then it
makes no sense at all to have CONFIG_TPM on vl.c.  We go for stubs or
CONFIG_TPM, both of them look bad, no?

Later, Juan.
