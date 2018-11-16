Received: from eggs.gnu.org ([2001:4830:134:3::10]:52592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1gNYrf-0001X7-MR
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1gNYrb-0004O1-Ke
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:48:31 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:42058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dimastep@yandex-team.ru>)
	id 1gNYrZ-0004Jf-3H
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:48:25 -0500
Date: Fri, 16 Nov 2018 10:48:11 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
Message-ID: <20181116074810.GA22738@dimastep-nix>
References: <1539919345-10703-1-git-send-email-jasowang@redhat.com>
	<1539919345-10703-25-git-send-email-jasowang@redhat.com>
	<20181113154133.GA9113@dimastep-nix>
	<60759e6b-b125-a7ce-b5d1-78ef5bb3f8a0@redhat.com>
	<20181114162335.GA31235@dimastep-nix>
	<eb191136-36be-1067-ef71-d8203d16aff3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb191136-36be-1067-ef71-d8203d16aff3@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL V2 24/26] net: ignore packet size greater
 than INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On Thu, Nov 15, 2018 at 10:47:04AM +0800, Jason Wang wrote:
>=20
> On 2018/11/15 =E4=B8=8A=E5=8D=8812:23, Dima Stepanov wrote:
> >On Wed, Nov 14, 2018 at 10:59:32AM +0800, Jason Wang wrote:
> >>On 2018/11/13 =E4=B8=8B=E5=8D=8811:41, Dima Stepanov wrote:
> >>>Hi Jason,
> >>>
> >>>I know that this patch has been already merged to stable, but i have=
 a
> >>>question:
> >>>
> >>>On Fri, Oct 19, 2018 at 11:22:23AM +0800, Jason Wang wrote:
> >>>>There should not be a reason for passing a packet size greater than
> >>>>INT_MAX. It's usually a hint of bug somewhere, so ignore packet siz=
e
> >>>>greater than INT_MAX in qemu_deliver_packet_iov()
> >>>>
> >>>>CC:qemu-stable@nongnu.org
> >>>>Reported-by: Daniel Shapira<daniel@twistlock.com>
> >>>>Reviewed-by: Michael S. Tsirkin<mst@redhat.com>
> >>>>Signed-off-by: Jason Wang<jasowang@redhat.com>
> >>>>---
> >>>>  net/net.c | 7 ++++++-
> >>>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>
> >>>>diff --git a/net/net.c b/net/net.c
> >>>>index c66847e..07c194a 100644
> >>>>--- a/net/net.c
> >>>>+++ b/net/net.c
> >>>>@@ -712,10 +712,15 @@ ssize_t qemu_deliver_packet_iov(NetClientStat=
e *sender,
> >>>>                                  void *opaque)
> >>>>  {
> >>>>      NetClientState *nc =3D opaque;
> >>>>+    size_t size =3D iov_size(iov, iovcnt);
> >>>>      int ret;
> >>>>+    if (size > INT_MAX) {
> >>>>+        return size;
> >>>Is it okay that the function returns ssize_t (signed), but the type =
of the
> >>>size variable is size_t (unsigned)? For now the top level routine ch=
ecks
> >>>the return value only for 0, but anyway we can return negative value
> >>>here instead of positive. What do you think?
> >>>
> >>>Regards, Dima.
> >>>
> >>Any non zero value should be ok here. Actually I think because of the
> >>conversion from size_t to ssize_t, caller actually see negative value=
?
> >I believe it depends. If long (ssize_t and size_t type) is 8 bytes, th=
en
> >the routine can sometimes return positive values and sometimes negativ=
e.
> >I fully agree that in the current case any non zero value should be
> >okay. I just wanted to point on the inconsistency in types and as a
> >result a return value.
>=20
>=20
> I see, want to post a patch for this?
>=20
> Thanks

Yes, will take a look into it and prepare a patch.

Thanks, Dima.
>=20
>=20
> >Dima.
> >>Thanks
> >>
