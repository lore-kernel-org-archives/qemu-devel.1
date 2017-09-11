Received: from eggs.gnu.org ([2001:4830:134:3::10]:51624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drPcd-00014X-Sv
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drPcY-0003NT-VF
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:23:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drPcY-0003Mu-O2
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:23:30 -0400
Date: Mon, 11 Sep 2017 16:23:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170911162322.6d82d0da@nial.brq.redhat.com>
In-Reply-To: <20170905201956.GF17184@localhost.localdomain>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-3-git-send-email-imammedo@redhat.com>
	<20170905201956.GF17184@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] cpu: make cpu_generic_init() abort
 QEMU on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, "Edgar
	E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Jia Liu <proljc@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Andrew Jones <drjones@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Fabien Chouteau <chouteau@adacore.com>, Jan Kiszka <jan.kiszka@web.de>, Yongbok Kim <yongbok.kim@imgtec.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <huth@tuxfamily.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>

On Tue, 5 Sep 2017 17:19:56 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Sep 04, 2017 at 04:00:58PM +0200, Igor Mammedov wrote:
> > Almost every user of cpu_generic_init() checks for
> > returned NULL and then reports failure in a custom way
> > and aborts process.
> > Some users assume that call can't fail and don't check
> > for failure, though they should have checked for it.
> > 
> > In either cases cpu_generic_init() failure is fatal,
> > so instead of checking for failure and reporting
> > it various ways, make cpu_generic_init() report
> > errors in consistent way and terminate QEMU on failure.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > Even though it's tree wide change, it's trivial so all
> > affected call sites are included within one patch.
> >   
> [...]
> > diff --git a/qom/cpu.c b/qom/cpu.c
> > index d715890..307d638 100644
> > --- a/qom/cpu.c
> > +++ b/qom/cpu.c
> > @@ -61,7 +61,7 @@ CPUState *cpu_create(const char *typename)
> >      if (err != NULL) {
> >          error_report_err(err);
> >          object_unref(OBJECT(cpu));
> > -        return NULL;
> > +        exit(EXIT_FAILURE);  
> 
> Isn't it simpler to use &error_fatal?
sure, I'll fix it up.
