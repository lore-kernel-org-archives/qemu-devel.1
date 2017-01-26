Received: from eggs.gnu.org ([2001:4830:134:3::10]:56240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWjiJ-0000lq-0T
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWjiF-0007Do-9t
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:03:43 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45624)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWjiF-0007D1-2i
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:03:39 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
	<20170126123429.5412.94368.stgit@PASHA-ISP>
	<e00dfc17-9dec-ea53-e86e-cf3089da659a@redhat.com>
In-Reply-To: <e00dfc17-9dec-ea53-e86e-cf3089da659a@redhat.com>
Date: Thu, 26 Jan 2017 16:03:39 +0300
Message-ID: <000c01d277d4$9d56f6e0$d804e4a0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v8 3/9] apic: save apic_delivered flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 26/01/2017 13:34, Pavel Dovgalyuk wrote:
> > This patch implements saving/restoring of static apic_delivered variable.
> >
> > v8: saving static variable only for one of the APICs
> >
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > ---
> >  hw/intc/apic_common.c           |   37 +++++++++++++++++++++++++++++++++++++
> >  include/hw/i386/apic_internal.h |    2 ++
> >  2 files changed, 39 insertions(+)
> >
> > diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> > index d78c885..edacb16 100644
> > --- a/hw/intc/apic_common.c
> > +++ b/hw/intc/apic_common.c
> > @@ -384,6 +384,29 @@ static bool apic_common_sipi_needed(void *opaque)
> >      return s->wait_for_sipi != 0;
> >  }
> >
> > +static bool apic_irq_delivered_needed(void *opaque)
> > +{
> > +    static APICCommonState *first_apic;
> > +    APICCommonState *s = APIC_COMMON(opaque);
> > +    if (!first_apic) {
> > +        first_apic = s;
> > +    }
> > +    return s == first_apic;
> 
> Should also check " && apic_irq_delivered != 0".

Reset of this variable when machine reboots is also forgotten.

Pavel Dovgalyuk
