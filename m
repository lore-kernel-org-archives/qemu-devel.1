Received: from eggs.gnu.org ([2001:4830:134:3::10]:35475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fdHYO-0003YX-CK
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fdHYN-000104-C6
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:01:20 -0400
Received: from forwardcorp1g.cmail.yandex.net ([2a02:6b8:0:1465::fd]:56471)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dimastep@yandex-team.ru>)
	id 1fdHYM-0000yi-Rr
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:01:19 -0400
Date: Wed, 11 Jul 2018 19:01:14 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
Message-ID: <20180711160114.GA7198@dimastep-nix>
References: <1528877995-5043-1-git-send-email-dimastep@yandex-team.ru>
	<1528877995-5043-3-git-send-email-dimastep@yandex-team.ru>
	<20180619141216.GA16512@dimastep-nix>
	<20180711083431.GA5085@dimastep-nix>
	<69f9565f-e5f9-54f3-03dd-e610bea47ddc@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <69f9565f-e5f9-54f3-03dd-e610bea47ddc@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] memory: fix possible NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, wrfsh@yandex-team.ru

Hi Phil,

On Wed, Jul 11, 2018 at 10:47:18AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Dima,
>=20
> On 07/11/2018 05:34 AM, Dima Stepanov wrote:
> > Gentle ping. CCing Paolo Bonzini.
> >=20
> > Regards, Dima.
> >=20
> > On Tue, Jun 19, 2018 at 05:12:16PM +0300, Dima Stepanov wrote:
> >> Ping.
> >>
> >> Regards, Dima.
> >>
> >> On Wed, Jun 13, 2018 at 11:19:55AM +0300, Dima Stepanov wrote:
> >>> In the memory_region_do_invalidate_mmio_ptr() routine the section
> >>> variable is intialized by the memory_region_find() call. The sectio=
n.mr
> >>> field can be set to NULL.
> >>>
> >>> Add the check for NULL before trying to drop a section.
> >>>
> >>> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> >>> ---
> >>>  memory.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/memory.c b/memory.c
> >>> index 3212acc..bb45248 100644
> >>> --- a/memory.c
> >>> +++ b/memory.c
> >>> @@ -2712,7 +2712,7 @@ static void memory_region_do_invalidate_mmio_=
ptr(CPUState *cpu,
> >>>      /* Reset dirty so this doesn't happen later. */
> >>>      cpu_physical_memory_test_and_clear_dirty(offset, size, 1);
> >>> =20
> >>> -    if (section.mr !=3D mr) {
> >>> +    if (section.mr && (section.mr !=3D mr)) {
>=20
> section.mr can't be NULL here.
>=20
> You can give the static analyzer a hint using "assert(section.mr);"

My point was:
  section =3D memory_region_find(mr, offset, size) ->
    ret =3D memory_region_find_rcu(mr, addr, size); ->
      MemoryRegionSection ret =3D { .mr =3D NULL };
      ...
      as =3D memory_region_to_address_space(root);
      if this call returns NULL, then the ret value will be returned
      (with .mr =3D=3D NULL)
But maybe it is impossible for this case. Thanks for the reply.

Regards, Dima.

>=20
> >>>          /* memory_region_find add a ref on section.mr */
> >>>          memory_region_unref(section.mr);
> >>>          if (MMIO_INTERFACE(section.mr->owner)) {
> >>> --=20
> >>> 2.7.4
> >>>
>=20
> Regards,
>=20
> Phil.
>=20
