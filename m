Received: from eggs.gnu.org ([2001:4830:134:3::10]:52023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cijMN-0002qn-Dl
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cijMJ-0002M5-B8
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:06:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cijMJ-0002LO-6E
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:06:35 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98A4A7AEBB
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 15:06:34 +0000 (UTC)
Date: Tue, 28 Feb 2017 16:06:24 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170228160629.4794f504@Igors-MacBook-Pro.local>
In-Reply-To: <1488291209-29430-2-git-send-email-marcel@redhat.com>
References: <1488291209-29430-1-git-send-email-marcel@redhat.com>
	<1488291209-29430-2-git-send-email-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 1/2] acpi: simplify _OSC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

On Tue, 28 Feb 2017 16:13:28 +0200
Marcel Apfelbaum <marcel@redhat.com> wrote:

> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> Our _OSC method has a bunch of unused code loading data
> into external CTRL and SUPP fields which are then never
> used. Drop this in favor of a single local variable.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 1c928ab..1da6d9f 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1803,7 +1803,7 @@ static Aml *build_q35_osc_method(void)
>      Aml *else_ctx;
>      Aml *method;
>      Aml *a_cwd1 = aml_name("CDW1");
> -    Aml *a_ctrl = aml_name("CTRL");
> +    Aml *a_ctrl = aml_local(0);
>  
>      method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
>      aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> @@ -1813,7 +1813,6 @@ static Aml *build_q35_osc_method(void)
>      aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
>      aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
>  
> -    aml_append(if_ctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
>      aml_append(if_ctx, aml_store(aml_name("CDW3"), a_ctrl));
>  
>      /*
> @@ -1898,8 +1897,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
>          aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> -        aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> -        aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>          aml_append(dev, build_q35_osc_method());
>          aml_append(sb_scope, dev);
>          aml_append(dsdt, sb_scope);
