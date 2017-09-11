Received: from eggs.gnu.org ([2001:4830:134:3::10]:33990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drQ4A-0007PZ-Q1
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drQ49-0007LW-Od
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:52:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drQ49-0007KM-Fr
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:52:01 -0400
Date: Mon, 11 Sep 2017 16:51:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170911165154.41c5aa48@nial.brq.redhat.com>
In-Reply-To: <d021bc33-5b0c-f5d2-e619-e06705a32043@tuxfamily.org>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-3-git-send-email-imammedo@redhat.com>
	<d021bc33-5b0c-f5d2-e619-e06705a32043@tuxfamily.org>
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
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, "Edgar
	E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Jia Liu <proljc@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Fabien Chouteau <chouteau@adacore.com>, Jan Kiszka <jan.kiszka@web.de>, Yongbok Kim <yongbok.kim@imgtec.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>

On Tue, 5 Sep 2017 07:41:51 +0200
Thomas Huth <huth@tuxfamily.org> wrote:

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
1st:
cpu_generic_init() should be removed once I convert all users to use
MachineState::cpu_type + cpu_create() instead of cpu_generic_init(cpu_model).
So no board would have to deal with cpu_model directly.

2nd:
device_add already does
  obj = object_new() + ... + obj.realize = true
hence cpu_create() is of no use there.
However cpu_create() is still useful as all users that
just need to create and realize cpu without extra configuration,
could benefit from unified error checking/message and 'small' code
deduplication as diffstat for this patch shows.

   38 files changed, 8 insertions(+), 169 deletions(-)

3rd:
parse_feature callbacks are meant to be called only once
and do nothing if called multiple times. They convert
'-cpu foo,features' option into a set of global properties which
are applied every created cpu instance of given type.
So when 'device_add cpu_foo' is called, there is no need to call
parse_features(). 


> 
>  Thomas
> 
