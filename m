Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FF2C33CB7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF1E20716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5MJ+HaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF1E20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwkNd-0005XZ-3N
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iwkMp-00058P-Ma
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iwkMo-0007Hd-82
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:14:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23126
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iwkMo-0007Gs-3F
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580292877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k1AqHbP7d74tmNNAPhVU3oRgP5Kl7yA2PYj7HrZRxNg=;
 b=A5MJ+HaF5VCXKBgssNV2ZxVvuZuNK8W+6mbfvWmEVnKyxWJqna2eIqkwREt808eBoPxErN
 C+j/284DOR3ooS3BUj2O0Gd7Wg6p6KF0sbASmkr5XL9ZwH2oZDLAorRzli6u7jHvlIIMeu
 EqhdaLDms+YAHsFMiotE7Dho45lOTCc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-w_1B2mQsOS-4Cps6Qks7kA-1; Wed, 29 Jan 2020 05:14:33 -0500
Received: by mail-qt1-f200.google.com with SMTP id r9so10492982qtc.4
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 02:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Rlt0kehN3QF2KGB6VErLQgpui21PKLAlCENcJk6yot4=;
 b=Y/z8BPrwGma5VvZ3tEHUt9mG23mieCg8/yd+gcYpEANqwrXdNkTZTRb0q719EGl5h/
 EykzMnZWQHtBx2nR8oVihVbp0Jwk8M1J8WazuHjyNV3vpaPZQzTgUX1sW3fYz2Yz+2df
 CujtN5YIFIR6GIB5eLh1GdG672lfaOxfgnXELFoxTuR3PNpq/9Uem05ewnHENy6nv/Pf
 ZuR2+zSosm7Jlf95BWPWBlKydPwmernP0DaSUI10fFoHRpOIbS5RDdOiQwsyvf3d+rvU
 oQgakSu+Bo5KEE247Le4BwSFlsGQ6ek3DtuGhtjvb0J1ObaHze9I/0s0zLAGSfgpdC1Z
 ex2Q==
X-Gm-Message-State: APjAAAXI1qNhVEMtslo5p1Pehn9BWotseeF2lF5Axrri5Cq+3PATh/dG
 fLjXPjyhWbTr/xt3NaBTJXhT/QSl2B2ckMjWpbfbGwe/eZ18JkmvHWAFJ8DH0OsC7bKCbW2FSqd
 /aUm1JQYlus6xVew=
X-Received: by 2002:a05:620a:9d9:: with SMTP id
 y25mr26921921qky.41.1580292872798; 
 Wed, 29 Jan 2020 02:14:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqzu2nrf6QYNHZGHQeM1OSuRlOKDi4U7WT8rVBHghm4Kw8Lp8BSj2CHDFz+AxJ5ac8HvLU21LA==
X-Received: by 2002:a05:620a:9d9:: with SMTP id
 y25mr26921890qky.41.1580292872381; 
 Wed, 29 Jan 2020 02:14:32 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id a24sm714862qkl.82.2020.01.29.02.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 02:14:31 -0800 (PST)
Date: Wed, 29 Jan 2020 05:14:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jing Liu <jing2.liu@linux.intel.com>
Subject: Re: [virtio-dev] [PATCH v2 5/5] virtio-mmio: MSI vector and event
 mapping
Message-ID: <20200129051247-mutt-send-email-mst@kernel.org>
References: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
 <1579614873-21907-6-git-send-email-jing2.liu@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1579614873-21907-6-git-send-email-jing2.liu@linux.intel.com>
X-MC-Unique: w_1B2mQsOS-4Cps6Qks7kA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 Chao Peng <chao.p.peng@linux.intel.com>, Liu Jiang <gerry@linux.alibaba.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 09:54:33PM +0800, Jing Liu wrote:
> Bit 1 msi_sharing reported in the MsiState register indicates the mapping=
 mode
> device uses.
>=20
> Bit 1 is 0 - device uses MSI non-sharing mode. This indicates vector per =
event and
> fixed static vectors and events relationship. This fits for devices with =
a high interrupt
> rate and best performance;
> Bit 1 is 1 - device uses MSI sharing mode. This indicates vectors and eve=
nts
> dynamic mapping and fits for devices not requiring a high interrupt rate.

It seems that sharing mode is a superset of non-sharing mode.
Isn't that right? E.g. with sharing mode drivers
can still avoid sharing if they like.

Maybe it should just be a hint to drivers whether to share
interrupts, instead of a completely different layout?

> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> ---
>  content.tex | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>  msi-state.c |  3 ++-
>  2 files changed, 49 insertions(+), 2 deletions(-)
>=20
> diff --git a/content.tex b/content.tex
> index dcf6c71..2fd1686 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1770,7 +1770,8 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
>    \hline
>    \mmioreg{MsiState}{MSI state}{0x0c4}{R}{%
>      When VIRTIO_F_MMIO_MSI has been negotiated, reading
> -    from this register returns the global MSI enable/disable status.
> +    from this register returns the global MSI enable/disable status
> +    and whether device uses MSI sharing mode.
>      \lstinputlisting{msi-state.c}
>    }
>    \hline
> @@ -1926,12 +1927,18 @@ \subsubsection{Device Initialization}\label{sec:V=
irtio Transport Options / Virti
>  mask and unmask the MSI vector applying to the one selected by writing
>  to \field{MsiVecSel}.
> =20
> +VIRTIO_MMIO_MSI_CMD_MAP_CONFIG command is to set the configuration event=
 and MSI vector
> +mapping. VIRTIO_MMIO_MSI_CMD_MAP_QUEUE is to set the queue event and MSI=
 vector
> +mapping. They SHOULD only be used in MSI sharing mode.
> +
>  \begin{lstlisting}
>  #define  VIRTIO_MMIO_MSI_CMD_ENABLE           0x1
>  #define  VIRTIO_MMIO_MSI_CMD_DISABLE          0x2
>  #define  VIRTIO_MMIO_MSI_CMD_CONFIGURE        0x3
>  #define  VIRTIO_MMIO_MSI_CMD_MASK             0x4
>  #define  VIRTIO_MMIO_MSI_CMD_UNMASK           0x5
> +#define  VIRTIO_MMIO_MSI_CMD_MAP_CONFIG       0x6
> +#define  VIRTIO_MMIO_MSI_CMD_MAP_QUEUE        0x7
>  \end{lstlisting}
> =20
>  Setting a special NO_VECTOR value means disabling an interrupt for an ev=
ent type.
> @@ -1941,10 +1948,49 @@ \subsubsection{Device Initialization}\label{sec:V=
irtio Transport Options / Virti
>  #define VIRTIO_MMIO_MSI_NO_VECTOR             0xffffffff
>  \end{lstlisting}
> =20
> +\subparagraph{MSI Vector and Event Mapping}\label{sec:Virtio Transport O=
ptions / Virtio Over MMIO / MMIO-specific Initialization And Device Operati=
on / Device Initialization / MSI Vector Configuration}
> +The reported \field{msi_sharing} bit in the \field{MsiState} return valu=
e shows
> +the MSI sharing mode that device uses.
> +
> +When \field{msi_sharing} bit is 0, it indicates the device uses non-shar=
ing mode
> +and vector per event fixed static relationship is used. The first vector=
 is for device
> +configuraiton change event, the second vector is for virtqueue 1, the th=
ird vector
> +is for virtqueue 2 and so on.
> +
> +When \field{msi_sharing} bit is 1, it indicates the device uses MSI shar=
ing mode,
> +and the vector and event mapping is dynamic. Writing \field{MsiVecSel}
> +followed by writing VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_M=
AP_QUEUE command
> +maps interrupts triggered by the configuration change/selected queue eve=
nts respectively
> +to the corresponding MSI vector.
> +
> +\devicenormative{\subparagraph}{MSI Vector Configuration}{Virtio Transpo=
rt Options / Virtio Over MMIO / MMIO-specific Initialization And Device Ope=
ration / MSI Vector Configuration}
> +
> +When the device reports \field{msi_sharing} bit as 0, it SHOULD support =
a number of
> +vectors that greater than the maximum number of virtqueues.
> +Device MUST report the number of vectors supported in \field{MsiVecNum}.
> +
> +When the device reports \field{msi_sharing} bit as 1, it SHOULD support =
at least
> +2 MSI vectors and MUST report in \field{MsiVecNum}. Device SHOULD suppor=
t mapping any
> +event type to any vector under \field{MsiVecNum}.
> +
> +Device MUST support unmapping any event type (NO_VECTOR).
> +
> +The device SHOULD restrict the reported \field{msi_sharing} and \field{M=
siVecNum}
> +to a value that might benefit system performance.
> +
> +\begin{note}
> +For example, a device which does not expect to send interrupts at a high=
 rate might
> +return \field{msi_sharing} bit as 1.
> +\end{note}
> +
>  \drivernormative{\subparagraph}{MSI Vector Configuration}{Virtio Transpo=
rt Options / Virtio Over MMIO / MMIO-specific Initialization And Device Ope=
ration / MSI Vector Configuration}
>  When VIRTIO_F_MMIO_MSI has been negotiated, driver should try to configu=
re
>  and enable MSI.
> =20
> +To set up the event and vector mapping for MSI sharing mode, driver SHOU=
LD
> +write a valid \field{MsiVecSel} followed by VIRTIO_MMIO_MSI_CMD_MAP_CONF=
IG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE
> +command to map the configuration change/selected queue events respective=
ly.
> +
>  To configure MSI vector, driver SHOULD firstly specify the MSI vector in=
dex by
>  writing to \field{MsiVecSel}.
>  Then notify the MSI address and data by writing to \field{MsiAddrLow}, \=
field{MsiAddrHigh},
> diff --git a/msi-state.c b/msi-state.c
> index b1fa0c1..d470be4 100644
> --- a/msi-state.c
> +++ b/msi-state.c
> @@ -1,4 +1,5 @@
>  le32 {
>      msi_enabled : 1;
> -    reserved : 31;
> +    msi_sharing: 1;
> +    reserved : 30;
>  };
> --=20
> 2.7.4
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


