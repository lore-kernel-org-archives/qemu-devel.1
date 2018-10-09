Received: from eggs.gnu.org ([2001:4830:134:3::10]:40359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g9vP3-0006bG-LN
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g9vP0-0006R0-5l
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:02:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g9vOz-0006Pv-NT
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:02:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB583C057E00
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 17:02:32 +0000 (UTC)
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-11-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0a73e268-650c-9488-9a93-0b66bc93b2b6@redhat.com>
Date: Tue, 9 Oct 2018 19:02:30 +0200
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-11-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/31] smbios: Clean up error handling in
 smbios_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 08/10/2018 19:31, Markus Armbruster wrote:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  smbios_entry_add() does that, and then exit()s.  It
> also passes &error_fatal to qemu_opts_validate().  Both wrong, but
> currently harmless, as its only caller passes &error_fatal.  Messed up
> in commit 1007a37e208.  Clean it up.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/smbios/smbios.c | 90 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 62 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index a27e54b2fa..920939454e 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -950,6 +950,7 @@ static void save_opt_list(size_t *ndest, const char ***dest,
>  
>  void smbios_entry_add(QemuOpts *opts, Error **errp)
>  {
> +    Error *err = NULL;
>      const char *val;
>  
>      assert(!smbios_immutable);
> @@ -960,12 +961,16 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>          int size;
>          struct smbios_table *table; /* legacy mode only */
>  
> -        qemu_opts_validate(opts, qemu_smbios_file_opts, &error_fatal);
> +        qemu_opts_validate(opts, qemu_smbios_file_opts, &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>  
>          size = get_image_size(val);
>          if (size == -1 || size < sizeof(struct smbios_structure_header)) {
> -            error_report("Cannot read SMBIOS file %s", val);
> -            exit(1);
> +            error_setg(errp, "Cannot read SMBIOS file %s", val);
> +            return;
>          }
>  
>          /*
> @@ -978,14 +983,15 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>                                                      smbios_tables_len);
>  
>          if (load_image(val, (uint8_t *)header) != size) {
> -            error_report("Failed to load SMBIOS file %s", val);
> -            exit(1);
> +            error_setg(errp, "Failed to load SMBIOS file %s", val);
> +            return;
>          }
>  
>          if (test_bit(header->type, have_fields_bitmap)) {
> -            error_report("can't load type %d struct, fields already specified!",
> -                         header->type);
> -            exit(1);
> +            error_setg(errp,
> +                       "can't load type %d struct, fields already specified!",
> +                       header->type);
> +            return;
>          }
>          set_bit(header->type, have_binfile_bitmap);
>  
> @@ -1030,19 +1036,23 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>          unsigned long type = strtoul(val, NULL, 0);
>  
>          if (type > SMBIOS_MAX_TYPE) {
> -            error_report("out of range!");
> -            exit(1);
> +            error_setg(errp, "out of range!");
> +            return;
>          }
>  
>          if (test_bit(type, have_binfile_bitmap)) {
> -            error_report("can't add fields, binary file already loaded!");
> -            exit(1);
> +            error_setg(errp, "can't add fields, binary file already loaded!");
> +            return;
>          }
>          set_bit(type, have_fields_bitmap);
>  
>          switch (type) {
>          case 0:
> -            qemu_opts_validate(opts, qemu_smbios_type0_opts, &error_fatal);
> +            qemu_opts_validate(opts, qemu_smbios_type0_opts, &err);
> +            if (err) {
> +                error_propagate(errp, err);
> +                return;
> +            }
>              save_opt(&type0.vendor, opts, "vendor");
>              save_opt(&type0.version, opts, "version");
>              save_opt(&type0.date, opts, "date");
> @@ -1051,14 +1061,18 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>              val = qemu_opt_get(opts, "release");
>              if (val) {
>                  if (sscanf(val, "%hhu.%hhu", &type0.major, &type0.minor) != 2) {
> -                    error_report("Invalid release");
> -                    exit(1);
> +                    error_setg(errp, "Invalid release");
> +                    return;
>                  }
>                  type0.have_major_minor = true;
>              }
>              return;
>          case 1:
> -            qemu_opts_validate(opts, qemu_smbios_type1_opts, &error_fatal);
> +            qemu_opts_validate(opts, qemu_smbios_type1_opts, &err);
> +            if (err) {
> +                error_propagate(errp, err);
> +                return;
> +            }
>              save_opt(&type1.manufacturer, opts, "manufacturer");
>              save_opt(&type1.product, opts, "product");
>              save_opt(&type1.version, opts, "version");
> @@ -1069,14 +1083,18 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>              val = qemu_opt_get(opts, "uuid");
>              if (val) {
>                  if (qemu_uuid_parse(val, &qemu_uuid) != 0) {
> -                    error_report("Invalid UUID");
> -                    exit(1);
> +                    error_setg(errp, "Invalid UUID");
> +                    return;
>                  }
>                  qemu_uuid_set = true;
>              }
>              return;
>          case 2:
> -            qemu_opts_validate(opts, qemu_smbios_type2_opts, &error_fatal);
> +            qemu_opts_validate(opts, qemu_smbios_type2_opts, &err);
> +            if (err) {
> +                error_propagate(errp, err);
> +                return;
> +            }
>              save_opt(&type2.manufacturer, opts, "manufacturer");
>              save_opt(&type2.product, opts, "product");
>              save_opt(&type2.version, opts, "version");
> @@ -1085,7 +1103,11 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>              save_opt(&type2.location, opts, "location");
>              return;
>          case 3:
> -            qemu_opts_validate(opts, qemu_smbios_type3_opts, &error_fatal);
> +            qemu_opts_validate(opts, qemu_smbios_type3_opts, &err);
> +            if (err) {
> +                error_propagate(errp, err);
> +                return;
> +            }
>              save_opt(&type3.manufacturer, opts, "manufacturer");
>              save_opt(&type3.version, opts, "version");
>              save_opt(&type3.serial, opts, "serial");
> @@ -1093,7 +1115,11 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>              save_opt(&type3.sku, opts, "sku");
>              return;
>          case 4:
> -            qemu_opts_validate(opts, qemu_smbios_type4_opts, &error_fatal);
> +            qemu_opts_validate(opts, qemu_smbios_type4_opts, &err);
> +            if (err) {
> +                error_propagate(errp, err);
> +                return;
> +            }
>              save_opt(&type4.sock_pfx, opts, "sock_pfx");
>              save_opt(&type4.manufacturer, opts, "manufacturer");
>              save_opt(&type4.version, opts, "version");
> @@ -1102,11 +1128,19 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>              save_opt(&type4.part, opts, "part");
>              return;
>          case 11:
> -            qemu_opts_validate(opts, qemu_smbios_type11_opts, &error_fatal);
> +            qemu_opts_validate(opts, qemu_smbios_type11_opts, &err);
> +            if (err) {
> +                error_propagate(errp, err);
> +                return;
> +            }
>              save_opt_list(&type11.nvalues, &type11.values, opts, "value");
>              return;
>          case 17:
> -            qemu_opts_validate(opts, qemu_smbios_type17_opts, &error_fatal);
> +            qemu_opts_validate(opts, qemu_smbios_type17_opts, &err);
> +            if (err) {
> +                error_propagate(errp, err);
> +                return;
> +            }
>              save_opt(&type17.loc_pfx, opts, "loc_pfx");
>              save_opt(&type17.bank, opts, "bank");
>              save_opt(&type17.manufacturer, opts, "manufacturer");
> @@ -1116,12 +1150,12 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>              type17.speed = qemu_opt_get_number(opts, "speed", 0);
>              return;
>          default:
> -            error_report("Don't know how to build fields for SMBIOS type %ld",
> -                         type);
> -            exit(1);
> +            error_setg(errp,
> +                       "Don't know how to build fields for SMBIOS type %ld",
> +                       type);
> +            return;
>          }
>      }
>  
> -    error_report("Must specify type= or file=");
> -    exit(1);
> +    error_setg(errp, "Must specify type= or file=");
>  }
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
