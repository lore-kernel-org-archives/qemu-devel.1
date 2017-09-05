Received: from eggs.gnu.org ([2001:4830:134:3::10]:49488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dpBvp-0000la-OO
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dpBvl-0005iS-14
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:22:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dpBvk-0005gX-Oh
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:22:08 -0400
Date: Tue, 5 Sep 2017 08:22:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170905112200.GV7570@localhost.localdomain>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-3-git-send-email-imammedo@redhat.com>
	<d021bc33-5b0c-f5d2-e619-e06705a32043@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d021bc33-5b0c-f5d2-e619-e06705a32043@tuxfamily.org>
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
To: Thomas Huth <huth@tuxfamily.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Fabien Chouteau <chouteau@adacore.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On Tue, Sep 05, 2017 at 07:41:51AM +0200, Thomas Huth wrote:
> On 04.09.2017 16:00, Igor Mammedov wrote:
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
> >      }
> >      return cpu;
> >  }
> > @@ -78,8 +78,9 @@ const char *cpu_parse_features(const char *typename, const char *cpu_model)
> >  
> >      oc = cpu_class_by_name(typename, model_pieces[0]);
> >      if (oc == NULL) {
> > +        error_report("unable to find CPU model '%s'", model_pieces[0]);
> >          g_strfreev(model_pieces);
> > -        return NULL;
> > +        exit(EXIT_FAILURE);
> >      }
> >  
> >      cpu_type = object_class_get_name(oc);
> > @@ -88,7 +89,7 @@ const char *cpu_parse_features(const char *typename, const char *cpu_model)
> >      g_strfreev(model_pieces);
> >      if (err != NULL) {
> >          error_report_err(err);
> > -        return NULL;
> > +        exit(EXIT_FAILURE);
> >      }
> >      return cpu_type;
> >  }
> > @@ -100,10 +101,8 @@ CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
> >       */
> >      const char *cpu_type = cpu_parse_features(typename, cpu_model);
> >  
> > -    if (cpu_type) {
> > -        return cpu_create(cpu_type);
> > -    }
> > -    return NULL;
> > +    assert(cpu_type);
> > +    return cpu_create(cpu_type);
> >  }
> 
> Not sure, but wouldn't it be better to do the error reporting and exit
> in cpu_generic_init() instead? In case we ever might want to re-use the
> create and parse_feature functions for device_add later (?), and then
> the functions must not exit directly anymore...

I would prefer that, but note that in that case
cpu_parse_features() shouldn't leave any global property
registered if an error is reported.  It would need to validate
all the input before registering any properties, or rollback the
global properties it already registered when reporting an error.

-- 
Eduardo
