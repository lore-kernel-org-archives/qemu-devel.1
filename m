Received: from eggs.gnu.org ([2001:4830:134:3::10]:43101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cQYxF-00010y-5l
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:21:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cQYxC-0005wj-1V
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:21:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cQYxB-0005wG-Ov
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:21:33 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BA124C50C
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 12:21:32 +0000 (UTC)
References: <20170108194041.10908-1-ehabkost@redhat.com>
	<20170108194041.10908-5-ehabkost@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <28ad7fe6-6023-d2f9-6708-ce018aefc1a1@redhat.com>
Date: Mon, 9 Jan 2017 13:21:28 +0100
MIME-Version: 1.0
In-Reply-To: <20170108194041.10908-5-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] pc: Add 2.9 machine-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 01/08/17 20:40, Eduardo Habkost wrote:
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Added extra backslash to PC_COMPAT_2_8 definition
>   * Suggested-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  include/hw/i386/pc.h |  2 ++
>  hw/i386/pc_piix.c    | 15 ++++++++++++---
>  hw/i386/pc_q35.c     | 13 +++++++++++--
>  3 files changed, 25 insertions(+), 5 deletions(-)

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index b22e699c46..230e9e70c5 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -375,6 +375,8 @@ int e820_get_num_entries(void);
>  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>  
>  #define PC_COMPAT_2_8 \
> +    HW_COMPAT_2_8 \
> +
>  
>  #define PC_COMPAT_2_7 \
>      HW_COMPAT_2_7 \
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 5e1adbe53c..9f102aa388 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -437,13 +437,24 @@ static void pc_i440fx_machine_options(MachineClass *m)
>      m->default_display = "std";
>  }
>  
> -static void pc_i440fx_2_8_machine_options(MachineClass *m)
> +static void pc_i440fx_2_9_machine_options(MachineClass *m)
>  {
>      pc_i440fx_machine_options(m);
>      m->alias = "pc";
>      m->is_default = 1;
>  }
>  
> +DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
> +                      pc_i440fx_2_9_machine_options);
> +
> +static void pc_i440fx_2_8_machine_options(MachineClass *m)
> +{
> +    pc_i440fx_2_9_machine_options(m);
> +    m->is_default = 0;
> +    m->alias = NULL;
> +    SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
> +}
> +
>  DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
>                        pc_i440fx_2_8_machine_options);
>  
> @@ -451,8 +462,6 @@ DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
>  static void pc_i440fx_2_7_machine_options(MachineClass *m)
>  {
>      pc_i440fx_2_8_machine_options(m);
> -    m->is_default = 0;
> -    m->alias = NULL;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_7);
>  }
>  
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d042fe0843..dd792a8547 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -301,19 +301,28 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->max_cpus = 288;
>  }
>  
> -static void pc_q35_2_8_machine_options(MachineClass *m)
> +static void pc_q35_2_9_machine_options(MachineClass *m)
>  {
>      pc_q35_machine_options(m);
>      m->alias = "q35";
>  }
>  
> +DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
> +                   pc_q35_2_9_machine_options);
> +
> +static void pc_q35_2_8_machine_options(MachineClass *m)
> +{
> +    pc_q35_2_9_machine_options(m);
> +    m->alias = NULL;
> +    SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
> +}
> +
>  DEFINE_Q35_MACHINE(v2_8, "pc-q35-2.8", NULL,
>                     pc_q35_2_8_machine_options);
>  
>  static void pc_q35_2_7_machine_options(MachineClass *m)
>  {
>      pc_q35_2_8_machine_options(m);
> -    m->alias = NULL;
>      m->max_cpus = 255;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_7);
>  }
> 
