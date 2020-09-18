Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542DFC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB56A2076B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5LFoGOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB56A2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJUe-0001rE-NI
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJJTD-0000EC-Dj
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:42:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53956
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJJTA-0000eI-Jn
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600447362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kYcvgR1rt4MWGwUO3I9SDea2B3bwFCG4j346ZD5vVxs=;
 b=e5LFoGOq/QDTgA0eH4FyVAmlyRZM61tre846MsHMCto9lvMztWOzk9hUZ/wMwWZQcVNjnu
 EcCr7uA8DGkRz0V3II7dWVqcbpN+C5KrbT6iVtMAf/jTYrcTtBZT5gQUgtqSbAbh+WA1yT
 fFXV3vESTkoXhy22A0sd4HIJy2i9gso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-pCCnfkXcNyeIGuPwv4Exrg-1; Fri, 18 Sep 2020 12:42:40 -0400
X-MC-Unique: pCCnfkXcNyeIGuPwv4Exrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED1D4188C130;
 Fri, 18 Sep 2020 16:42:38 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94C9D73662;
 Fri, 18 Sep 2020 16:42:38 +0000 (UTC)
Date: Fri, 18 Sep 2020 12:42:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v3 1/2] Introduce (x86) CPU model deprecation API
Message-ID: <20200918164237.GZ7594@habkost.net>
References: <1600245434-63021-1-git-send-email-robert.hu@linux.intel.com>
 <20200917181831.GU7594@habkost.net>
 <509a84f209fe6ac60b2e4b913a49190d0f1eeaa2.camel@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <509a84f209fe6ac60b2e4b913a49190d0f1eeaa2.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 11:06:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, robert.hu@intel.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 01:48:18PM +0800, Robert Hoo wrote:
> On Thu, 2020-09-17 at 14:18 -0400, Eduardo Habkost wrote:
> > I think the patch looks better now, thanks!
> > 
> > Just a few minor questions and suggestions:
> > 
> > On Wed, Sep 16, 2020 at 04:37:13PM +0800, Robert Hoo wrote:
> > > Complement versioned CPU model framework with the ability of
> > > marking some
> > > versions deprecated. When that CPU model is chosen, get some
> > > warning. The
> > > warning message is customized, e.g. telling in which future QEMU
> > > version will
> > > it be obsoleted.
> > > The deprecation message will also appear by x86_cpu_list_entry(),
> > > e.g. '-cpu
> > > help'.
> > > QMP 'query-cpu-definitions' will also return a bool value
> > > indicating the
> > > deprecation status.
> > > 
> > > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > > ---
> > > Changelog
> > > v3:
> > > Make the deprecation implementation CPUClass generic.
> > > 
> > > v2:
> > > Move deprecation check from parse_cpu_option() to
> > > machine_run_board_init(), so
> > > that it can cover implicit cpu_type assignment cases.
> > 
> > What do you mean by implicit cpu_type assignment cases?
> 
> Means the case that user doesn't explicitly assign '-cpu xxx' but
> implicitly inherits machine's default cpu type.
> vl.c
>     /* parse features once if machine provides default cpu_type */
>     current_machine->cpu_type = machine_class->default_cpu_type;
>     if (cpu_option) {
>         current_machine->cpu_type = parse_cpu_option(cpu_option);
>     }

We probably would never deprecate CPU models that are still used
by default, so this is not an issue.

> > 
> > Doing it inside parse_cpu_option() like you did in v1 will make
> > the deprecation warnings appear for *-user too (which is a good
> > thing).
> > 
> So you changed your mind;-)

Sorry, I don't remember suggesting this.  I couldn't find any
reply from myself in v1, and v2 already had the code moved to
machine_run_board_init().

Note that doing the check in machine_run_board_init() is not
necessarily a problem, I'm just trying to understand why the code
was moved from parse_cpu_option() to machine_run_board_init()
between v1 and v2.


> 
> Could you shed more details? I don't get this point. What do you mean 
> "*-user"?

I mean QEMU user mode emulator, bsd-user and linux-user (e.g. the
qemu-x86_64 binary).  They call parse_cpu_option() as well.

> 
> > > Add qapi new member documentation. Thanks Eric for comment and
> > > guidance on qapi.
> > > 
> > >  hw/core/machine.c        | 12 ++++++++++--
> > >  include/hw/core/cpu.h    |  6 ++++++
> > >  qapi/machine-target.json |  7 ++++++-
> > >  target/i386/cpu.c        | 29 +++++++++++++++++++++++------
> > >  4 files changed, 45 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > index ea26d61..b41f88d 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -1095,6 +1095,8 @@ MemoryRegion
> > > *machine_consume_memdev(MachineState *machine,
> > >  void machine_run_board_init(MachineState *machine)
> > >  {
> > >      MachineClass *machine_class = MACHINE_GET_CLASS(machine);
> > > +    ObjectClass *oc = object_class_by_name(machine->cpu_type);
> > > +    CPUClass *cc;
> > >  
> > >      if (machine->ram_memdev_id) {
> > >          Object *o;
> > > @@ -1114,11 +1116,10 @@ void machine_run_board_init(MachineState
> > > *machine)
> > >       * specified a CPU with -cpu check here that the user CPU is
> > > supported.
> > >       */
> > >      if (machine_class->valid_cpu_types && machine->cpu_type) {
> > > -        ObjectClass *class = object_class_by_name(machine-
> > > >cpu_type);
> > >          int i;
> > >  
> > >          for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> > > -            if (object_class_dynamic_cast(class,
> > > +            if (object_class_dynamic_cast(oc,
> > >                                            machine_class-
> > > >valid_cpu_types[i])) {
> > >                  /* The user specificed CPU is in the valid field,
> > > we are
> > >                   * good to go.
> > > @@ -1141,6 +1142,13 @@ void machine_run_board_init(MachineState
> > > *machine)
> > >          }
> > >      }
> > >  
> > > +    /* Check if CPU type is deprecated and warn if so */
> > > +    cc = CPU_CLASS(oc);
> > > +    if (cc->deprecated) {
> > > +        warn_report("CPU model %s is deprecated -- %s", machine-
> > > >cpu_type,
> > > +                    cc->deprecation_note);
> > > +    }
> > > +
> > >      machine_class->init(machine);
> > >  }
> > >  
> > > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > > index 99dc33f..c4b17c8 100644
> > > --- a/include/hw/core/cpu.h
> > > +++ b/include/hw/core/cpu.h
> > > @@ -155,6 +155,10 @@ struct TranslationBlock;
> > >   * @disas_set_info: Setup architecture specific components of
> > > disassembly info
> > >   * @adjust_watchpoint_address: Perform a target-specific
> > > adjustment to an
> > >   * address before attempting to match it against watchpoints.
> > > + * @deprecated: True if this CPU model is deprecated (going to be
> > > removed in
> > > + *              near future).
> > > + * @deprecation_note: Message about the deprecation. e.g. Since
> > > which version
> > > + *                    will it be obsoleted.
> > 
> > We don't need two separate fields if (deprecation_note != NULL)
> > means the CPU model is deprecated.  This is how it was
> > implemented in MachineClass (see MachineClass::deprecation_reason).
> > 
> 
> Agree.
> I think such applies to X86CPUModel::deprecated and X86CPUModel::note
> as well; and rename X86CPUModel::note --> deprecation_note. How do you
> like this?

Sound good!

> 
> > >   *
> > >   * Represents a CPU family or model.
> > >   */
> > > @@ -221,6 +225,8 @@ struct CPUClass {
> > >      vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr,
> > > int len);
> > >      void (*tcg_initialize)(void);
> > >  
> > > +    bool deprecated;
> > > +    const char *deprecation_note;
> > >      /* Keep non-pointer data at the end to minimize holes.  */
> > >      int gdb_num_core_regs;
> > >      bool gdb_stop_before_watchpoint;
> > > diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> > > index 698850c..fec3bb8 100644
> > > --- a/qapi/machine-target.json
> > > +++ b/qapi/machine-target.json
> > > @@ -286,6 +286,10 @@
> > >  #            in the VM configuration, because aliases may stop
> > > being
> > >  #            migration-safe in the future (since 4.1)
> > >  #
> > > +# @deprecated: If true, this CPU model is deprecated and may be
> > > removed in
> > > +#              in some future version of QEMU according to the
> > > QEMU deprecation
> > > +#              policy. (since 5.2)
> > > +#
> > >  # @unavailable-features is a list of QOM property names that
> > >  # represent CPU model attributes that prevent the CPU from
> > > running.
> > >  # If the QOM property is read-only, that means there's no known
> > > @@ -310,7 +314,8 @@
> > >              'static': 'bool',
> > >              '*unavailable-features': [ 'str' ],
> > >              'typename': 'str',
> > > -            '*alias-of' : 'str' },
> > > +            '*alias-of' : 'str',
> > > +            'deprecated' : 'bool' },
> > >    'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) ||
> > > defined(TARGET_I386) || defined(TARGET_S390X) ||
> > > defined(TARGET_MIPS)' }
> > >  
> > >  ##
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 49d8958..9cb82b7 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -1716,6 +1716,7 @@ typedef struct X86CPUVersionDefinition {
> > >      const char *alias;
> > >      const char *note;
> > >      PropValue *props;
> > > +    bool       deprecated;
> > >  } X86CPUVersionDefinition;
> > >  
> > >  /* Base definition for a CPU model */
> > > @@ -1751,6 +1752,11 @@ struct X86CPUModel {
> > >       * This matters only for "-cpu help" and query-cpu-definitions
> > >       */
> > >      bool is_alias;
> > > +    /*
> > > +     * If true, this model is deprecated, and may be removed in
> > > the future.
> > > +     * Trying to use it now will cause a warning.
> > > +     */
> > > +    bool deprecated;
> > >  };
> > >  
> > >  /* Get full model name for CPU version */
> > > @@ -5096,6 +5102,7 @@ static void x86_cpu_definition_entry(gpointer
> > > data, gpointer user_data)
> > >      info->migration_safe = cc->migration_safe;
> > >      info->has_migration_safe = true;
> > >      info->q_static = cc->static_model;
> > > +    info->deprecated = cc->model ? cc->model->deprecated : false;
> > >      /*
> > >       * Old machine types won't report aliases, so that alias
> > > translation
> > >       * doesn't break compatibility with previous QEMU versions.
> > > @@ -5486,9 +5493,12 @@ static void
> > > x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
> > >  {
> > >      X86CPUModel *model = data;
> > >      X86CPUClass *xcc = X86_CPU_CLASS(oc);
> > > +    CPUClass *cc = CPU_CLASS(oc);
> > >  
> > >      xcc->model = model;
> > >      xcc->migration_safe = true;
> > > +    cc->deprecated = model->deprecated;
> > > +    cc->deprecation_note = g_strdup(model->note);
> > 
> > The meaning of cc->deprecation_note and model->note is a bit
> > ambiguous here.  model->note is not necessarily a deprecation
> > note, but its contents are being copied unconditionally to
> > cc->deprecation_note.
> > 
> > What about setting cc->deprecation_note only if and only if the
> > model is deprecated?
> > 
> Agree. Since X86CPUModel::note is actually unused by anything now,
> going to rename it to deprecation_note as aforementioned.

.note is used by all the CPU models that set .note.  See for
example:

x86 Cascadelake-Server-v1  Intel Xeon Processor (Cascadelake)
x86 Cascadelake-Server-v2  Intel Xeon Processor (Cascadelake) [ARCH_CAPABILITIES]
x86 Cascadelake-Server-v3  Intel Xeon Processor (Cascadelake) [ARCH_CAPABILITIES, no TSX]
x86 Cascadelake-Server-v4  Intel Xeon Processor (Cascadelake) [ARCH_CAPABILITIES, no TSX]


> 
> A side concern,
> cc->deprecation_note = g_strdup(model->note);
> 
> I don's see where free the cc object. Assuming the dup'ed string, as
> well as object, will last through QEMU process life time, freed
> implicitly as this process gone. Is my understanding right?

We never free QOM class structs (like CPUClass), so that's OK.

> > 
> > >  }
> > >  
> > >  static void x86_register_cpu_model_type(const char *name,
> > > X86CPUModel *model)
> > > @@ -5524,21 +5534,28 @@ static void
> > > x86_register_cpudef_types(X86CPUDefinition *def)
> > >      x86_register_cpu_model_type(def->name, m);
> > >  
> > >      /* Versioned models: */
> > > -
> > >      for (vdef = x86_cpu_def_get_versions(def); vdef->version;
> > > vdef++) {
> > > -        X86CPUModel *m = g_new0(X86CPUModel, 1);
> > > +        X86CPUModel *vm = g_new0(X86CPUModel, 1);
> > >          g_autofree char *name =
> > >              x86_cpu_versioned_model_name(def, vdef->version);
> > > -        m->cpudef = def;
> > > -        m->version = vdef->version;
> > > -        m->note = vdef->note;
> > > -        x86_register_cpu_model_type(name, m);
> > > +        vm->cpudef = def;
> > > +        vm->version = vdef->version;
> > > +        vm->note = vdef->note;
> > > +        vm->deprecated = vdef->deprecated;
> > > +        /* If Model-v1 is deprecated, Model is deprecated. */
> > > +        if (vdef->version == 1 && vdef->deprecated == true) {
> > > +            m->deprecated = true;
> > > +            m->note = vdef->note;
> > 
> > I'm not sure this rule will always apply.  If we deprecate
> > "Model-v1" but not "Model-v2", we probably don't want "Model" to
> > be deprecated too.
> 
> Agree
> > 
> > Considering that we don't have cases where specific versions are
> > being deprecated, what about making it as simple as possible and
> > just add a new X86CPUDefinition::deprecation_note field?  No need
> > for any new fields in X86CPUModel (model->cpudef->deprecation_note
> > can be used directly), no need for two new fields in CPUClass
> > (just deprecation_note).
> 
> How about eliminating the unversioned CPU model? Then we can still have
> deprecation_note in X86CPUModel, which looks more natural to me than in
> X86CPUDefition.
> For anyway, the unversioned CPU model will eventually be instantiated
> to its some versioned CPU model. It's like a virtual class.

What do you mean by eliminating the unversioned CPU model?  Keep
in mind that we need "-cpu Model" to keep working, because of
compatibility and also because "-cpu Model" is more convenient.

There are ways the representation of CPU models + aliases +
versions can be improved, but I assume you wouldn't want a large
refactor of the CPU model/version table to get in the way of a
simple feature.

> 
> > 
> > If one day we decide to deprecate just some versions of a CPU
> > model, we can extend X86CPUVersionDefinition in the future.
> > 
> > > +        }
> > > +        x86_register_cpu_model_type(name, vm);
> > >  
> > >          if (vdef->alias) {
> > >              X86CPUModel *am = g_new0(X86CPUModel, 1);
> > >              am->cpudef = def;
> > >              am->version = vdef->version;
> > >              am->is_alias = true;
> > > +            am->note = vdef->note;
> > > +            am->deprecated = vdef->deprecated;
> > >              x86_register_cpu_model_type(vdef->alias, am);
> > >          }
> > >      }
> > > -- 
> > > 1.8.3.1
> > > 
> > 
> > 
> 

-- 
Eduardo


