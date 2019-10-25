Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C214CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BE62070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPumel9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BE62070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtGm-0000QS-U6
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNtDn-0002mG-C8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNtDj-0008K0-Kw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27757
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNtDj-0008JQ-Ah
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571985430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XBwtRIVAG4I8F4JAzIQFF0TzaeX9/82MfwukBU0ZXQA=;
 b=fPumel9uWTqDKSSPCRuUP8oC89kWKsG7NJY7G3LVrr/BQlB5uD3w9sLbecKH0njD9s5gjg
 ugInFRqyZ3rfV8MNy5894EHUqv/LGWdU0iINzxCuEg7d5QU/ucnYRd+RHbAZQnrJCG9qyq
 C8E8m+DnBlCsjQfEYNQBVLJI/RGSoXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-4ZO2EVZDNn6mDU_a0Cp7EQ-1; Fri, 25 Oct 2019 02:37:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2CDF107AD31;
 Fri, 25 Oct 2019 06:37:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7CA560BE0;
 Fri, 25 Oct 2019 06:37:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA8921138619; Fri, 25 Oct 2019 08:36:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 7/7] cpu: Add `machine` parameter to query-cpu-definitions
References: <20191025022553.25298-1-ehabkost@redhat.com>
 <20191025022553.25298-8-ehabkost@redhat.com>
Date: Fri, 25 Oct 2019 08:36:59 +0200
In-Reply-To: <20191025022553.25298-8-ehabkost@redhat.com> (Eduardo Habkost's
 message of "Thu, 24 Oct 2019 23:25:53 -0300")
Message-ID: <8736fhmius.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 4ZO2EVZDNn6mDU_a0Cp7EQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> The new parameter can be used by management software to query for
> CPU model alias information for multiple machines without
> restarting QEMU.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qapi/machine-target.json                   | 14 +++++++-
>  target/arm/helper.c                        |  4 ++-
>  target/i386/cpu.c                          | 16 +++++++--
>  target/mips/helper.c                       |  4 ++-
>  target/ppc/translate_init.inc.c            |  4 ++-
>  target/s390x/cpu_models.c                  |  4 ++-
>  tests/acceptance/x86_cpu_model_versions.py | 42 ++++++++++++++++++++++
>  7 files changed, 81 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 55310a6aa2..7bff3811fe 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -281,6 +281,10 @@

This is CpuDefinitionInfo.

>  #
>  # @alias-of: Name of CPU model this model is an alias for.  The target o=
f the
>  #            CPU model alias may change depending on the machine type.
> +#            If the @machine argument was provided to query-cpu-definiti=
ons,
> +#            alias information that machine type will be returned.

"for that machine type"

> +#            If @machine is not provided, alias information for
> +#            the current machine will be returned.
>  #            Management software is supposed to translate CPU model alia=
ses
>  #            in the VM configuration, because aliases may stop being
>  #            migration-safe in the future (since 4.1)
> @@ -317,9 +321,17 @@
   ##
   # @query-cpu-definitions:
>  #
>  # Return a list of supported virtual CPU definitions
>  #
> +# @machine: Name of machine type.  The command returns some data
> +#           that machine-specific.  This overrides the machine type

"that is machine-specific"

> +#           used to look up that information.  This can be used,
> +#           for example, to query machine-specific CPU model aliases
> +#           without restarting QEMU (since 4.2)
> +#
>  # Returns: a list of CpuDefInfo
>  #
>  # Since: 1.2.0
>  ##
> -{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
> +{ 'command': 'query-cpu-definitions',
> +  'data': { '*machine': 'str' },
> +  'returns': ['CpuDefinitionInfo'],
>    'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I3=
86) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }

I'm afraid the doc comment is less than clear.  Before I can suggest
improvements, I have questions.

Looks like @alias-of is the only part of the return value that changes
when I re-run query-cpu-definitions with another @machine argument.
Correct?

How is this going to be used?  Will management software run
query-cpu-definitions for each machine type returned by query-machines?
Or just for a few of them?

> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0d9a2d2ab7..96f9fe7fff 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6965,7 +6965,9 @@ static void arm_cpu_add_definition(gpointer data, g=
pointer user_data)
>      *cpu_list =3D entry;
>  }
> =20
> -CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> +CpuDefinitionInfoList *qmp_query_cpu_definitions(bool has_machine,
> +                                                 const char *machine,
> +                                                 Error **errp)
>  {
>      CpuDefinitionInfoList *cpu_list =3D NULL;
>      GSList *list;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 67d1eca4ed..ae633793ed 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4078,11 +4078,23 @@ static void x86_cpu_definition_entry(gpointer dat=
a, gpointer user_data)
>      args->cpu_list =3D entry;
>  }
> =20
> -CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> +CpuDefinitionInfoList *qmp_query_cpu_definitions(bool has_machine,
> +                                                 const char *machine,
> +                                                 Error **errp)
>  {
>      X86CPUDefinitionArgs args =3D { .cpu_list =3D NULL };
>      GSList *list;
> -    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
> +    MachineClass *mc;
> +
> +    if (!has_machine) {
> +        mc =3D MACHINE_GET_CLASS(qdev_get_machine());
> +    } else {
> +        mc =3D machine_find_class(machine);
> +        if (!mc) {
> +            error_setg(errp, "Machine type '%s' not found", machine);
> +            return NULL;
> +        }
> +    }
> =20
>      args.default_version =3D default_cpu_version_for_machine(mc);
>      list =3D get_sorted_cpu_model_list();
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index a2b6459b05..a73c767462 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -1481,7 +1481,9 @@ static void mips_cpu_add_definition(gpointer data, =
gpointer user_data)
>      *cpu_list =3D entry;
>  }
> =20
> -CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> +CpuDefinitionInfoList *qmp_query_cpu_definitions(bool has_machine,
> +                                                 const char *machine,
> +                                                 Error **errp)
>  {
>      CpuDefinitionInfoList *cpu_list =3D NULL;
>      GSList *list;
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index ba726dec4d..4493309c4c 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10350,7 +10350,9 @@ static void ppc_cpu_defs_entry(gpointer data, gpo=
inter user_data)
>      *first =3D entry;
>  }
> =20
> -CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> +CpuDefinitionInfoList *qmp_query_cpu_definitions(bool has_machine,
> +                                                 const char *machine,
> +                                                 Error **errp)
>  {
>      CpuDefinitionInfoList *cpu_list =3D NULL;
>      GSList *list;
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 7e92fb2e15..e40f1f6bec 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -456,7 +456,9 @@ static void create_cpu_model_list(ObjectClass *klass,=
 void *opaque)
>      *cpu_list =3D entry;
>  }
> =20
> -CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> +CpuDefinitionInfoList *qmp_query_cpu_definitions(bool has_machine,
> +                                                 const char *machine,
> +                                                 Error **errp)
>  {
>      struct CpuDefinitionInfoListData list_data =3D {
>          .list =3D NULL,

Should the commit message explain why all implementations but one ignore
@machine?

> diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptanc=
e/x86_cpu_model_versions.py
> index 5fc9ca4bc6..79c5250243 100644
> --- a/tests/acceptance/x86_cpu_model_versions.py
> +++ b/tests/acceptance/x86_cpu_model_versions.py
> @@ -234,6 +234,48 @@ class X86CPUModelAliases(avocado_qemu.Test):
> =20
>          self.validate_aliases(cpus)
> =20
> +    def test_machine_arg_none(self):
> +        """Check if unversioned CPU model is an alias pointing to right =
version"""
> +        vm1 =3D self.get_vm()
> +        vm1.add_args('-S')
> +        vm1.set_machine('pc-i440fx-4.0')
> +        vm1.launch()
> +        cpus1 =3D dict((m['name'], m.get('alias-of')) for m in vm1.comma=
nd('query-cpu-definitions', machine=3D'none'))
> +        vm1.shutdown()
> +
> +        vm2 =3D self.get_vm()
> +        vm2.add_args('-S')
> +        vm2.set_machine('none')
> +        vm2.launch()
> +        cpus2 =3D dict((m['name'], m.get('alias-of')) for m in vm2.comma=
nd('query-cpu-definitions'))
> +        vm1.shutdown()
> +
> +        self.assertEquals(cpus1, cpus2)
> +
> +    def test_machine_arg_4_1(self):
> +        """Check if unversioned CPU model is an alias pointing to right =
version"""
> +        vm1 =3D self.get_vm()
> +        vm1.add_args('-S')
> +        vm1.set_machine('pc-i440fx-4.0')
> +        vm1.launch()
> +        cpus1 =3D dict((m['name'], m.get('alias-of')) for m in vm1.comma=
nd('query-cpu-definitions', machine=3D'pc-i440fx-4.1'))
> +        vm1.shutdown()
> +
> +        vm2 =3D self.get_vm()
> +        vm2.add_args('-S')
> +        vm2.set_machine('pc-i440fx-4.1')
> +        vm2.launch()
> +        cpus2 =3D dict((m['name'], m.get('alias-of')) for m in vm2.comma=
nd('query-cpu-definitions'))
> +        vm1.shutdown()
> +
> +        self.assertEquals(cpus1, cpus2)
> +
> +    def test_invalid_machine(self):
> +        self.vm.add_args('-S')
> +        self.vm.launch()
> +        r =3D self.vm.qmp('query-cpu-definitions', machine=3D'invalid-ma=
chine-123')
> +        self.assertIn('error', r)
> +
> =20
>  class CascadelakeArchCapabilities(avocado_qemu.Test):
>      """

Tests look good to me.

I admit to being confused on when to use the tests/acceptance/ framework
and when to use qtest.


