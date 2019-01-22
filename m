Received: from eggs.gnu.org ([209.51.188.92]:37703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1glkl7-0000cs-6Q
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 20:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1glkl6-0001v4-2Z
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 20:21:45 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:42992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1glkl5-0001uL-Sx
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 20:21:44 -0500
Received: by mail-io1-xd42.google.com with SMTP id x6so17852763ioa.9
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 17:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20190120071337.55595-1-liq3ea@163.com>
	<20190120071337.55595-2-liq3ea@163.com>
	<66f7e560-2e3e-0efc-6a80-9a44dff71324@redhat.com>
In-Reply-To: <66f7e560-2e3e-0efc-6a80-9a44dff71324@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 22 Jan 2019 09:21:06 +0800
Message-ID: <CAKXe6SLAxE1Qv3MX4=Crgju+ApRsiDKwY84KU5ZMH-f+aNBjmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: fw_cfg: add a function to get
 the fw_cfg file entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Laszlo Ersek <lersek@redhat.com> =E4=BA=8E2019=E5=B9=B41=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=885:32=E5=86=99=E9=81=93=EF=BC=9A

> On 01/20/19 08:13, Li Qiang wrote:
> > This is useful to write qtest about fw_cfg file entry.
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  tests/libqos/fw_cfg.c | 33 +++++++++++++++++++++++++++++++++
> >  tests/libqos/fw_cfg.h |  2 ++
> >  2 files changed, 35 insertions(+)
> >
> > diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
> > index d0889d1e22..e2b0cae7cd 100644
> > --- a/tests/libqos/fw_cfg.c
> > +++ b/tests/libqos/fw_cfg.c
> > @@ -16,6 +16,7 @@
> >  #include "libqos/fw_cfg.h"
> >  #include "libqtest.h"
> >  #include "qemu/bswap.h"
> > +#include "standard-headers/linux/qemu_fw_cfg.h"
> >
> >  void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
> >  {
> > @@ -54,6 +55,38 @@ uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t ke=
y)
> >      return le64_to_cpu(value);
> >  }
> >
> > +size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
> > +                      void *data, size_t buflen)
> > +{
> > +    uint32_t count;
> > +    uint32_t i;
> > +    unsigned char *filesbuf =3D NULL;
> > +    uint32_t dsize;
>
> dsize should be size_t
>
>
OK.


> > +    struct fw_cfg_file *p;
>
> Please use a better variable name, such as "dir_entry" or similar.
>
>
OK.


> > +    size_t filesize =3D 0;
> > +
> > +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
> > +    count =3D be32_to_cpu(count);
> > +    dsize =3D sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
>
> where does "struct fw_cfg_file" come from?
>
>
>From include/standard-headers/linux/qemu_fw_cfg.h


> ... more precisely: why use it over the "FWCfgFile" typedef? (applies to
> the declaration of "p" as well).
>
>
Ok, I think we should use include/hw/nvram/fw_cfg.h.

Thanks,
Li Qiang


> > +    filesbuf =3D g_malloc0(dsize);
> > +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
> > +    p =3D (struct fw_cfg_file *)(filesbuf + sizeof(uint32_t));
> > +    for (i =3D 0; i < count; ++i, ++p) {
> > +        if (!strcmp(p->name, filename)) {
> > +            uint32_t len =3D be32_to_cpu(p->size);
> > +            uint16_t sel =3D be16_to_cpu(p->select);
> > +            filesize =3D len;
> > +            if (len > buflen) {
> > +                len =3D buflen;
> > +            }
> > +            qfw_cfg_get(fw_cfg, sel, data, len);
> > +            break;
> > +        }
> > +    }
> > +    g_free(filesbuf);
> > +    return filesize;
> > +}
> > +
> >  static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
> >  {
> >      qtest_writew(fw_cfg->qts, fw_cfg->base, key);
> > diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
> > index 0353416af0..de73722e67 100644
> > --- a/tests/libqos/fw_cfg.h
> > +++ b/tests/libqos/fw_cfg.h
> > @@ -31,6 +31,8 @@ void qfw_cfg_get(QFWCFG *fw_cfg, uint16_t key, void
> *data, size_t len);
> >  uint16_t qfw_cfg_get_u16(QFWCFG *fw_cfg, uint16_t key);
> >  uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
> >  uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
> > +size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
> > +                      void *data, size_t buflen);
> >
> >  QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
> >  QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
> >
>
> Looks OK to me otherwise.
>
> Thanks,
> Laszlo
>
