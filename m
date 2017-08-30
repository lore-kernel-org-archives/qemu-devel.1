Received: from eggs.gnu.org ([2001:4830:134:3::10]:53904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dn1JV-0000og-KD
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dn1JU-0001b4-PW
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:37:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dn1JU-0001ak-Fc
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:37:40 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170830104554.GD18526@redhat.com> (Daniel P. Berrange's message
	of "Wed, 30 Aug 2017 11:45:54 +0100")
References: <20170823083901.852-1-quintela@redhat.com>
	<20170823083901.852-3-quintela@redhat.com>
	<20170823115327.GC2648@work-vm>
	<bbe64c5c-8906-2bf9-92a8-8fda49100505@kaod.org>
	<6b5e898b-89d9-2323-5ca9-0cd212d39ec1@redhat.com>
	<20170830104554.GD18526@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 30 Aug 2017 13:37:32 +0200
Message-ID: <87val55ls3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: Make acpid test compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, lvivier@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> On Tue, Aug 29, 2017 at 03:17:25PM -0500, Eric Blake wrote:
>> On 08/28/2017 09:41 AM, C=C3=A9dric Le Goater wrote:
>> > On 08/23/2017 01:53 PM, Dr. David Alan Gilbert wrote:
>> >> * Juan Quintela (quintela@redhat.com) wrote:
>> >>> Compiler gets confused with the size of the struct, so move form
>> >>> g_new0() to g_malloc0().
>> >>>
>> >>> I *think* that the problem is in gcc (or glib for that matter), but
>> >>> the documentation of the g_new0 states that 1sts first argument is an
>> >>> struct type, and uint32_t is not an struct type.
>> >>>
>> >>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> >>> ---
>>=20
>> >>>=20=20
>> >>>      /* get the addresses of the tables pointed by rsdt */
>> >>> -    tables =3D g_new0(uint32_t, tables_nr);
>> >>> +    tables =3D g_malloc0(sizeof(uint32_t) * tables_nr);
>> >>
>>=20
>> > I fixed that one with :
>> >=20
>> > @@ -40,7 +40,7 @@ static uint32_t acpi_find_vgia(void)
>> >      AcpiRsdpDescriptor rsdp_table;
>> >      uint32_t rsdt;
>> >      AcpiRsdtDescriptorRev1 rsdt_table;
>> > -    int tables_nr;
>> > +    uint32_t tables_nr;
>>=20
>> I like this one better (multiplication in g_malloc0() makes me worry
>> about overflow; using unsigned math to avoid the problem is nicer).  Are
>> we going to see a v2 of this patch series?
>
> It should really be size_t, because it is assigned from the result of
> a size_t calculation, but you then also need to change a later assert
> which was relying on it being signed:
>
> @@ -40,7 +40,7 @@ static uint32_t acpi_find_vgia(void)
>      AcpiRsdpDescriptor rsdp_table;
>      uint32_t rsdt;
>      AcpiRsdtDescriptorRev1 rsdt_table;
> -    int tables_nr;
> +    size_t tables_nr;

I was using this already.

>      uint32_t *tables;
>      AcpiTableHeader ssdt_table;
>      VgidTable vgid_table;
> @@ -62,9 +62,9 @@ static uint32_t acpi_find_vgia(void)
>      ACPI_ASSERT_CMP(rsdt_table.signature, "RSDT");
>=20=20
>      /* compute the table entries in rsdt */
> +    g_assert_cmpint(rsdt_table.length, >, sizeof(AcpiRsdtDescriptorRev1)=
);
>      tables_nr =3D (rsdt_table.length - sizeof(AcpiRsdtDescriptorRev1)) /
>                  sizeof(uint32_t);
> -    g_assert_cmpint(tables_nr, >, 0);
>=20=20
>      /* get the addresses of the tables pointed by rsdt */
>      tables =3D g_new0(uint32_t, tables_nr);
>

And here we are, this mail arrived after I sent my new series.  Will
wait for more comments and resend later.

Thanks, Juan.
