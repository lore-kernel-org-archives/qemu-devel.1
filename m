Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCF6C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EFA222D9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jrl0h5Ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EFA222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbGV-0007M4-VU
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBbBm-0000DO-1s
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBbBk-0005u3-Pc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:28:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43259
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBbBk-0005sc-ER
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583832515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZlxkTczhaRiaXvEvoJ5L2pxrMwqWhjFeqRWtxzs5zrg=;
 b=Jrl0h5Ka2DEyw7g2FODmBsm7kiRlXkfVSCVoIoz2IwYMrjNnAVU1ELVVWDZd8eICSsodyk
 891n6yUxR43i/XOuGR1ugPnPvA1qb2bj2wfE7VEcpQ5/m2X1I7THeczmjrFOLCxneQR96+
 onMtcaVxsW2GWenD7zTepn9mE2RwKuY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-s7kIJZXTO5mywcBnYRllOA-1; Tue, 10 Mar 2020 05:28:33 -0400
X-MC-Unique: s7kIJZXTO5mywcBnYRllOA-1
Received: by mail-qv1-f70.google.com with SMTP id k1so7909120qvw.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 02:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8ddoh4Vrnlrg2ZZggY0Uo3Lw11pw4ROayJvLgYBkbBs=;
 b=MKFEw1wS1YyhtjCo2FMeUQY0RmcH+IHG7hjkaxlVeK2jiEZnyJvdkjCVnxxJPESG+F
 SpJgalobcluqponwkIcpiMwp9fFX4Dmv0p8Ecx3GbrUjfKk+6lJohf3/nvZw7aOT2wuQ
 QGzD4xNcABqPEUbANVCohPbDDkveHIpIyQhL9mEdlTItR7RGSNzZdFavAG9gEx808jMO
 zg6hV/KJQnNVV/WF8b3OjPjbacdIn67BYJqwl5kjOkz/uezkA8bPzk+Grw0pk8a+fVMO
 K2FPcWfcMahj0ECIfaTW5SeMj9LxyXq5UdrkZRP+mkd8X4yOcw64gDkdeaQSEUIg0MYq
 fd9Q==
X-Gm-Message-State: ANhLgQ27T0B5q9XT81KlH91WxbCZoHjTKPZZSNmQDnCpfcpMRniva/cu
 AWA4Uk+PRq/B8py1W0JIEXlN/TFFelV7zsjK7YPBfdOPYvIwD3e/CMT2xFVXgsg/9bCPnvFpfWB
 oe41gEXtObOYYXBs=
X-Received: by 2002:ad4:52eb:: with SMTP id p11mr17011950qvu.211.1583832512722; 
 Tue, 10 Mar 2020 02:28:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt/0cV+IhTucSdF3U5RFa52qmfzE68X/rf3SxJCPpc3X2EKWGRxg3AmukmTHTHD7fz0hrpAqw==
X-Received: by 2002:ad4:52eb:: with SMTP id p11mr17011937qvu.211.1583832512496; 
 Tue, 10 Mar 2020 02:28:32 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id v80sm23419799qka.15.2020.03.10.02.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 02:28:31 -0700 (PDT)
Date: Tue, 10 Mar 2020 05:28:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 06/14] hw/i386/vmport: Define enum for all commands
Message-ID: <20200310052327-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-7-liran.alon@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200309235411.76587-7-liran.alon@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 01:54:03AM +0200, Liran Alon wrote:
> No functional change.
>=20
> Defining an enum for all VMPort commands have the following advantages:
> * It gets rid of the error-prone requirement to update VMPORT_ENTRIES
> when new VMPort commands are added to QEMU.
> * It makes it clear to know by looking at one place at the source, what
> are all the VMPort commands supported by QEMU.
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  hw/i386/vmmouse.c    | 18 ++++++------------
>  hw/i386/vmport.c     | 11 ++---------
>  include/hw/i386/pc.h | 11 ++++++++++-
>  3 files changed, 18 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index e8e62bd96b8c..a61042fc0c5e 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -33,12 +33,6 @@
>  /* debug only vmmouse */
>  //#define DEBUG_VMMOUSE
> =20
> -/* VMMouse Commands */
> -#define VMMOUSE_GETVERSION=0910
> -#define VMMOUSE_DATA=09=0939
> -#define VMMOUSE_STATUS=09=0940
> -#define VMMOUSE_COMMAND=09=0941
> -
>  #define VMMOUSE_READ_ID=09=09=090x45414552
>  #define VMMOUSE_DISABLE=09=09=090x000000f5
>  #define VMMOUSE_REQUEST_RELATIVE=090x4c455252
> @@ -196,10 +190,10 @@ static uint32_t vmmouse_ioport_read(void *opaque, u=
int32_t addr)
>      command =3D data[2] & 0xFFFF;
> =20
>      switch (command) {
> -    case VMMOUSE_STATUS:
> +    case VMPORT_CMD_VMMOUSE_STATUS:
>          data[0] =3D vmmouse_get_status(s);
>          break;
> -    case VMMOUSE_COMMAND:
> +    case VMPORT_CMD_VMMOUSE_COMMAND:
>          switch (data[1]) {
>          case VMMOUSE_DISABLE:
>              vmmouse_disable(s);
> @@ -218,7 +212,7 @@ static uint32_t vmmouse_ioport_read(void *opaque, uin=
t32_t addr)
>              break;
>          }
>          break;
> -    case VMMOUSE_DATA:
> +    case VMPORT_CMD_VMMOUSE_DATA:
>          vmmouse_data(s, data, data[1]);
>          break;
>      default:
> @@ -275,9 +269,9 @@ static void vmmouse_realizefn(DeviceState *dev, Error=
 **errp)
>          return;
>      }
> =20
> -    vmport_register(VMMOUSE_STATUS, vmmouse_ioport_read, s);
> -    vmport_register(VMMOUSE_COMMAND, vmmouse_ioport_read, s);
> -    vmport_register(VMMOUSE_DATA, vmmouse_ioport_read, s);
> +    vmport_register(VMPORT_CMD_VMMOUSE_STATUS, vmmouse_ioport_read, s);
> +    vmport_register(VMPORT_CMD_VMMOUSE_COMMAND, vmmouse_ioport_read, s);
> +    vmport_register(VMPORT_CMD_VMMOUSE_DATA, vmmouse_ioport_read, s);
>  }
> =20
>  static Property vmmouse_properties[] =3D {
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index c03f57f2f636..2ae5afc42b50 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -30,10 +30,6 @@
>  #include "qemu/log.h"
>  #include "trace.h"
> =20
> -#define VMPORT_CMD_GETVERSION 0x0a
> -#define VMPORT_CMD_GETRAMSIZE 0x14
> -
> -#define VMPORT_ENTRIES 0x2c
>  #define VMPORT_MAGIC   0x564D5868
> =20
>  typedef enum {
> @@ -60,12 +56,9 @@ typedef struct VMPortState {
> =20
>  static VMPortState *port_state;
> =20
> -void vmport_register(unsigned char command, VMPortReadFunc *func, void *=
opaque)
> +void vmport_register(VMPortCommand command, VMPortReadFunc *func, void *=
opaque)
>  {
> -    if (command >=3D VMPORT_ENTRIES) {
> -        return;
> -    }
> -
> +    assert(command < VMPORT_ENTRIES);
>      trace_vmport_register(command, func, opaque);
>      port_state->func[command] =3D func;
>      port_state->opaque[command] =3D opaque;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index d5ac76d54e1f..7f15a01137b1 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -138,12 +138,21 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_e=
nabled);
>  #define TYPE_VMPORT "vmport"
>  typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
> =20
> +typedef enum {
> +    VMPORT_CMD_GETVERSION       =3D 10,
> +    VMPORT_CMD_GETRAMSIZE       =3D 20,
> +    VMPORT_CMD_VMMOUSE_DATA     =3D 39,
> +    VMPORT_CMD_VMMOUSE_STATUS   =3D 40,
> +    VMPORT_CMD_VMMOUSE_COMMAND  =3D 41,
> +    VMPORT_ENTRIES
> +} VMPortCommand;
> +

Please don't, let's leave pc.h alone. If you must add a new header for
vmport/vmmouse and put this stuff there.

>  static inline void vmport_init(ISABus *bus)
>  {
>      isa_create_simple(bus, TYPE_VMPORT);
>  }
> =20
> -void vmport_register(unsigned char command, VMPortReadFunc *func, void *=
opaque);
> +void vmport_register(VMPortCommand command, VMPortReadFunc *func, void *=
opaque);
>  void vmmouse_get_data(uint32_t *data);
>  void vmmouse_set_data(const uint32_t *data);
> =20
> --=20
> 2.20.1


