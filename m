Received: from eggs.gnu.org ([209.51.188.92]:35203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1ggSDw-0002Bg-Nm
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1ggSDp-0003Uz-Be
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:33:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ggSDh-0003Rx-1s
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:33:23 -0500
Received: by mail-oi1-f194.google.com with SMTP id v6so35477215oif.2
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 02:33:20 -0800 (PST)
MIME-Version: 1.0
References: <1544063533-10139-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1544063533-10139-3-git-send-email-lizhijian@cn.fujitsu.com>
	<20181221111136-mutt-send-email-mst@kernel.org>
	<a04239e5-8b87-6b90-f8c7-e9c893acceac@cn.fujitsu.com>
In-Reply-To: <a04239e5-8b87-6b90-f8c7-e9c893acceac@cn.fujitsu.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 7 Jan 2019 11:33:08 +0100
Message-ID: <CAGxU2F5jpU1Tam0C+ZPEuYGZj=J3V5hk7rkxHgW75-V+vCeShw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 2/4] refactor load_image_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, zhijianx.li@intel.com, Philippe Mathieu Daude <philmd@redhat.com>, qemu-devel@nongnu.org, philip.li@intel.com

On Mon, Dec 24, 2018 at 3:16 AM Li Zhijian <lizhijian@cn.fujitsu.com> wrote=
:
>
>
> On 12/22/18 00:12, Michael S. Tsirkin wrote:
> > On Thu, Dec 06, 2018 at 10:32:11AM +0800, Li Zhijian wrote:
> >> Don't expect read(2) can always read as many as it's told.
> >>
> >> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > This is more a theoretical bugfix than a refactoring right?
>
> Yes=EF=BC=8C it does.
>
> how about change the title to : "enhance reading on load_image_size()" or=
 such

Maybe something like this: "hw/core/loader.c: Read as long as possible
in load_image_size()"

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> Thanks
> Zhijian
>
>
> >
> >> ---
> >> V4: add reviewed-by tag
> >> ---
> >>   hw/core/loader.c | 11 +++++------
> >>   1 file changed, 5 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/hw/core/loader.c b/hw/core/loader.c
> >> index fa41842..9cbceab 100644
> >> --- a/hw/core/loader.c
> >> +++ b/hw/core/loader.c
> >> @@ -77,21 +77,20 @@ int64_t get_image_size(const char *filename)
> >>   ssize_t load_image_size(const char *filename, void *addr, size_t siz=
e)
> >>   {
> >>       int fd;
> >> -    ssize_t actsize;
> >> +    ssize_t actsize, l =3D 0;
> >>
> >>       fd =3D open(filename, O_RDONLY | O_BINARY);
> >>       if (fd < 0) {
> >>           return -1;
> >>       }
> >>
> >> -    actsize =3D read(fd, addr, size);
> >> -    if (actsize < 0) {
> >> -        close(fd);
> >> -        return -1;
> >> +    while ((actsize =3D read(fd, addr + l, size - l)) > 0) {
> >> +        l +=3D actsize;
> >>       }
> >> +
> >>       close(fd);
> >>
> >> -    return actsize;
> >> +    return actsize < 0 ? -1 : l;
> >>   }
> >>
> >>   /* read()-like version */
> >> --
> >> 2.7.4
> >
> >
> >
> --
> Best regards.
> Li Zhijian (8528)
>
>
>


--=20
Stefano Garzarella
Red Hat
