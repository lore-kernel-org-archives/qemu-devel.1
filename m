Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38557C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E994520716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELaANGR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E994520716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwkLu-0004e7-53
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iwkL9-0004Cm-SC
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iwkL6-0002Yf-0k
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:12:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50737
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iwkL5-0002TZ-JL
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580292768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFv34zPokDmQe4miEmV/vCHSsftJjS+7ML/8RZHKRzQ=;
 b=ELaANGR5WEMJkCEBK9/bqIGbvij3wfFE408p1yP3CFzfXV7aMwi/68te3QPd4iKnxHxuOw
 8T3rkMO3mhJy6o34R4ufPKGNo4VdmFJz6NiH4jYtiDZLqerUY54kWuDwbquLo9actUa8uj
 4mS5gUX9lDmloM+S0YtTPaGaJ1eqi0M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-F2DYEgTYO9myJKRhye3lrA-1; Wed, 29 Jan 2020 05:12:45 -0500
Received: by mail-qt1-f198.google.com with SMTP id r9so10489197qtc.4
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 02:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mB15bcSS1+9wToP/4V851ez/NpDYolnlJSkxIQhHUfM=;
 b=YuLUsDv+X44BSdNJQ9BJUANvHw9MxyPhvSPlsCC4hpcENx9ownukbuN9QyB3ysWRJX
 Ny9PGY3WP+cVuuXA4W0AWxPhL1wmZ6GWxKLRT+YbMGjgg2NV7B7QrI44G3nYxsUoVaMw
 ByrsypgD9jL8v7G3aYcFIEFNjCKbpi3+AvEqzhCil3dEuLigi8Z47/ncl+pOVKWcEb/h
 EEnW7Adm1FrG2NU6QFcccbPaPrv3BaJRiM64ht7C5H97pBIwMeVu6e6UwpGl+qkbsPqH
 9YvpKfslDUbjNd0N2rOzgCRgWHJDTE6OrJrUfe80ClpO4ZtJQ3BcA1I5FGxO27d76Rbz
 /EcA==
X-Gm-Message-State: APjAAAXXpJW3xBmnHguGec77LWpXenpV7fQKEHRjbIb9YWYVrMDOed3t
 kgXJY7UdSlRMZfxmj2YTxFMp2byTNwJLa3BUAiCQnusqTfsZybx75hXA0tY99BE/tyZ82f92gKy
 lkP8sJzOQ0mCfD1U=
X-Received: by 2002:a37:6292:: with SMTP id w140mr27865108qkb.65.1580292764938; 
 Wed, 29 Jan 2020 02:12:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwAUx/KsP1PhEUG8vlmwKOKv2NV+8JdzpSrvGpOKuShPyiwUHW4zdi2JXEvQB0tphbgjSQMg==
X-Received: by 2002:a37:6292:: with SMTP id w140mr27865076qkb.65.1580292764463; 
 Wed, 29 Jan 2020 02:12:44 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id i28sm842769qtc.57.2020.01.29.02.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 02:12:43 -0800 (PST)
Date: Wed, 29 Jan 2020 05:12:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jing Liu <jing2.liu@linux.intel.com>
Subject: Re: [virtio-dev] [PATCH v2 4/5] virtio-mmio: Introduce MSI details
Message-ID: <20200129050656-mutt-send-email-mst@kernel.org>
References: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
 <1579614873-21907-5-git-send-email-jing2.liu@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1579614873-21907-5-git-send-email-jing2.liu@linux.intel.com>
X-MC-Unique: F2DYEgTYO9myJKRhye3lrA-1
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

On Tue, Jan 21, 2020 at 09:54:32PM +0800, Jing Liu wrote:
> With VIRTIO_F_MMIO_MSI feature bit offered, the Message Signal
> Interrupts (MSI) is supported as first priority. For any reason it
> fails to use MSI, it need use the single dedicated interrupt as before.
>=20
> For MSI vectors and events mapping relationship, introduce in next patch.
>=20
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>


So we have a concept of "MSI vectors" here, which can be
selected and configured and which in the
following patch are mapped to VQs either 1:1 or dynamically.


My question is, do we need this indirection?

In fact an MSI vector is just an address/data pair.

So it seems that instead, we could just have commands specifying
MSI address/data pairs for each VQ, and separately for config changes.

It is useful to have hypervisor hint to guest how many different
pairs should be allocated, and that could be the RO max value.


> ---
>  content.tex | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
------
>  msi-state.c |   4 ++
>  2 files changed, 159 insertions(+), 16 deletions(-)
>  create mode 100644 msi-state.c
>=20
> diff --git a/content.tex b/content.tex
> index ff151ba..dcf6c71 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1687,7 +1687,8 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
>    \hline=20
>    \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
>      Reading from this register returns a bit mask of events that
> -    caused the device interrupt to be asserted.
> +    caused the device interrupt to be asserted. This is only used
> +    when MSI is not enabled.
>      The following events are possible:
>      \begin{description}
>        \item[Used Buffer Notification] - bit 0 - the interrupt was assert=
ed
> @@ -1701,7 +1702,7 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
>    \mmioreg{InterruptACK}{Interrupt acknowledge}{0x064}{W}{%
>      Writing a value with bits set as defined in \field{InterruptStatus}
>      to this register notifies the device that events causing
> -    the interrupt have been handled.
> +    the interrupt have been handled. This is only used when MSI is not e=
nabled.
>    }
>    \hline=20
>    \mmioreg{Status}{Device status}{0x070}{RW}{%
> @@ -1760,6 +1761,47 @@ \subsection{MMIO Device Register Layout}\label{sec=
:Virtio Transport Options / Vi
>      \field{SHMSel} is unused) results in a base address of
>      0xffffffffffffffff.
>    }
> +  \hline
> +  \mmioreg{MsiVecNum}{MSI max vector number}{0x0c0}{R}{%
> +    When VIRTIO_F_MMIO_MSI has been negotiated, reading
> +    from this register returns the maximum MSI vector number
> +    that device supports.
> +  }
> +  \hline
> +  \mmioreg{MsiState}{MSI state}{0x0c4}{R}{%
> +    When VIRTIO_F_MMIO_MSI has been negotiated, reading
> +    from this register returns the global MSI enable/disable status.
> +    \lstinputlisting{msi-state.c}
> +  }
> +  \hline
> +  \mmioreg{MsiCmd}{MSI command}{0x0c8}{W}{%
> +    When VIRTIO_F_MMIO_MSI has been negotiated, writing
> +    to this register executes the corresponding command to device.
> +    Part of this applies to the MSI vector selected by writing to \field=
{MsiVecSel}.
> +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-spec=
ific Initialization And Device Operation / Device Initialization / MSI Vect=
or Configuration}
> +    for using details.
> +  }
> +  \hline
> +  \mmioreg{MsiVecSel}{MSI vector index}{0x0d0}{W}{%
> +    When VIRTIO_F_MMIO_MSI has been negotiated, writing
> +    to this register selects the MSI vector index that the following ope=
rations
> +    on \field{MsiAddrLow}, \field{MsiAddrHigh}, \field{MsiData} and part=
 of
> +    \field{MsiCmd} commands specified in \ref{sec:Virtio Transport Optio=
ns / Virtio Over MMIO / MMIO-specific Initialization And Device Operation /=
 Device Initialization / MSI Vector Configuration}
> +    apply to. The index number of the first vector is zero (0x0).
> +  }
> +  \hline
> +  \mmiodreg{MsiAddrLow}{MsiAddrHigh}{MSI 64 bit address}{0x0d4}{0x0d8}{W=
}{%
> +    When VIRTIO_F_MMIO_MSI has been negotiated, writing
> +    to these two registers (lower 32 bits of the address to \field{MsiAd=
drLow},
> +    higher 32 bits to \field{MsiAddrHigh}) notifies the device about the
> +    MSI address. This applies to the MSI vector selected by writing to \=
field{MsiVecSel}.
> +  }
> +  \hline
> +  \mmioreg{MsiData}{MSI 32 bit data}{0x0dc}{W}{%
> +    When VIRTIO_F_MMIO_MSI has been negotiated, writing
> +    to this register notifies the device about the MSI data.
> +    This applies to the MSI vector selected by writing to \field{MsiVecS=
el}.
> +  }
>    \hline=20
>    \mmioreg{ConfigGeneration}{Configuration atomicity value}{0x0fc}{R}{
>      Reading from this register returns a value describing a version of t=
he device-specific configuration space (see \field{Config}).
> @@ -1783,10 +1825,16 @@ \subsection{MMIO Device Register Layout}\label{se=
c:Virtio Transport Options / Vi
> =20
>  The device MUST return value 0x2 in \field{Version}.
> =20
> -The device MUST present each event by setting the corresponding bit in \=
field{InterruptStatus} from the
> +When MSI is disabled, the device MUST present each event by setting the
> +corresponding bit in \field{InterruptStatus} from the
>  moment it takes place, until the driver acknowledges the interrupt
> -by writing a corresponding bit mask to the \field{InterruptACK} register=
.  Bits which
> -do not represent events which took place MUST be zero.
> +by writing a corresponding bit mask to the \field{InterruptACK} register=
.
> +Bits which do not represent events which took place MUST be zero.
> +
> +When MSI is enabled, the device MUST NOT set \field{InterruptStatus} and=
 MUST
> +ignore \field{InterruptACK}.
> +
> +Upon reset, the device MUST clear \field{msi_enabled} bit in \field{MsiS=
tate}.
> =20
>  Upon reset, the device MUST clear all bits in \field{InterruptStatus} an=
d ready bits in the
>  \field{QueueReady} register for all queues in the device.
> @@ -1835,7 +1883,12 @@ \subsection{MMIO Device Register Layout}\label{sec=
:Virtio Transport Options / Vi
> =20
>  The driver MUST ignore undefined bits in \field{InterruptStatus}.
> =20
> -The driver MUST write a value with a bit mask describing events it handl=
ed into \field{InterruptACK} when
> +The driver MUST ignore undefined bits in the return value of reading \fi=
eld{MsiState}.
> +
> +When MSI is enabled, the driver MUST NOT access \field{InterruptStatus} =
and MUST NOT write to \field{InterruptACK}.
> +
> +When MSI is disabled, the driver MUST write a value with a bit mask
> +describing events it handled into \field{InterruptACK} when
>  it finishes handling an interrupt and MUST NOT set any of the undefined =
bits in the value.
> =20
>  \subsection{MMIO-specific Initialization And Device Operation}\label{sec=
:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization=
 And Device Operation}
> @@ -1856,6 +1909,63 @@ \subsubsection{Device Initialization}\label{sec:Vi=
rtio Transport Options / Virti
>  Further initialization MUST follow the procedure described in
>  \ref{sec:General Initialization And Device Operation / Device Initializa=
tion}~\nameref{sec:General Initialization And Device Operation / Device Ini=
tialization}.
> =20
> +\paragraph{MSI Vector Configuration}\label{sec:Virtio Transport Options =
/ Virtio Over MMIO / MMIO-specific Initialization And Device Operation / De=
vice Initialization / MSI Vector Configuration}
> +The VIRTIO_F_MMIO_MSI feature bit offered by device shows the capability
> +using MSI vectors for virtqueue and configuration events.
> +
> +When VIRTIO_F_MMIO_MSI has been negotiated,
> +writing \field{MsiCmd} executes a corresponding command to the device:
> +
> +VIRTIO_MMIO_MSI_CMD_ENABLE and VIRTIO_MMIO_MSI_CMD_DISABLE commands set =
global
> +MSI enable and disable status.
> +
> +VIRTIO_MMIO_MSI_CMD_CONFIGURE is used to configure the MSI vector
> +applying to the one selected by writing to \field{MsiVecSel}.
> +
> +VIRTIO_MMIO_MSI_CMD_MASK and VIRTIO_MMIO_MSI_CMD_UNMASK commands are use=
d to
> +mask and unmask the MSI vector applying to the one selected by writing
> +to \field{MsiVecSel}.
> +
> +\begin{lstlisting}
> +#define  VIRTIO_MMIO_MSI_CMD_ENABLE           0x1
> +#define  VIRTIO_MMIO_MSI_CMD_DISABLE          0x2
> +#define  VIRTIO_MMIO_MSI_CMD_CONFIGURE        0x3
> +#define  VIRTIO_MMIO_MSI_CMD_MASK             0x4
> +#define  VIRTIO_MMIO_MSI_CMD_UNMASK           0x5
> +\end{lstlisting}
> +
> +Setting a special NO_VECTOR value means disabling an interrupt for an ev=
ent type.
> +
> +\begin{lstlisting}
> +/* Vector value used to disable MSI for event */
> +#define VIRTIO_MMIO_MSI_NO_VECTOR             0xffffffff
> +\end{lstlisting}
> +
> +\drivernormative{\subparagraph}{MSI Vector Configuration}{Virtio Transpo=
rt Options / Virtio Over MMIO / MMIO-specific Initialization And Device Ope=
ration / MSI Vector Configuration}
> +When VIRTIO_F_MMIO_MSI has been negotiated, driver should try to configu=
re
> +and enable MSI.
> +
> +To configure MSI vector, driver SHOULD firstly specify the MSI vector in=
dex by
> +writing to \field{MsiVecSel}.
> +Then notify the MSI address and data by writing to \field{MsiAddrLow}, \=
field{MsiAddrHigh},
> +and \field{MsiData}, and immediately follow a \field{MsiCmd} write opera=
tion
> +using VIRTIO_MMIO_MSI_CMD_CONFIGURE to device for configuring an event t=
o
> +this MSI vector.
> +
> +After all MSI vectors are configured, driver SHOULD set global MSI enabl=
ed
> +by writing to \field{MsiCmd} using VIRTIO_MMIO_MSI_CMD_ENABLE.
> +
> +Driver should use VIRTIO_MMIO_MSI_CMD_DISABLE when disabling MSI.
> +
> +Driver should use VIRTIO_MMIO_MSI_CMD_MASK with an MSI index \field{MsiV=
ecSel}
> +to prohibit the event from the corresponding interrupt source.
> +
> +Driver should use VIRTIO_MMIO_MSI_CMD_UNMASK with an MSI index \field{Ms=
iVecSel}
> +to recover the event from the corresponding interrupt source.
> +
> +If driver fails to setup any event with a vector,
> +it MUST disable MSI by \field{MsiCmd} and use the single dedicated inter=
rupt for device.
> +
>  \subsubsection{Notification Structure Layout}\label{sec:Virtio Transport=
 Options / Virtio Over MMIO / MMIO-specific Initialization And Device Opera=
tion / Notification Structure Layout}
> =20
>  When VIRTIO_F_MMIO_NOTIFICATION has been negotiated, the notification lo=
cation is calculated
> @@ -1908,6 +2018,12 @@ \subsubsection{Virtqueue Configuration}\label{sec:=
Virtio Transport Options / Vir
>     \field{QueueDriverLow}/\field{QueueDriverHigh} and
>     \field{QueueDeviceLow}/\field{QueueDeviceHigh} register pairs.
> =20
> +\item Write MSI address \field{MsiAddrLow}/\field{MsiAddrHigh},
> +MSI data \field{MsiData} and MSI update command \field{MsiCtrlStat} with=
 corresponding
> +virtqueue index to update
> +MSI configuration for device requesting interrupts triggered by
> +virtqueue events.
> +
>  \item Write 0x1 to \field{QueueReady}.
>  \end{enumerate}
> =20
> @@ -1932,20 +2048,43 @@ \subsubsection{Available Buffer Notifications}\la=
bel{sec:Virtio Transport Option
> =20
>  \subsubsection{Notifications From The Device}\label{sec:Virtio Transport=
 Options / Virtio Over MMIO / MMIO-specific Initialization And Device Opera=
tion / Notifications From The Device}
> =20
> -The memory mapped virtio device is using a single, dedicated
> +If MSI is enabled, the memory mapped virtio
> +device uses appropriate MSI interrupt message
> +for configuration change notification and used buffer notification which=
 are
> +configured by \field{MsiAddrLow}, \field{MsoAddrHigh} and \field{MsiData=
}.
> +
> +If MSI is not enabled, the memory mapped virtio device
> +uses a single, dedicated
>  interrupt signal, which is asserted when at least one of the
>  bits described in the description of \field{InterruptStatus}
> -is set. This is how the device sends a used buffer notification
> -or a configuration change notification to the device.
> +is set.
> =20
>  \drivernormative{\paragraph}{Notifications From The Device}{Virtio Trans=
port Options / Virtio Over MMIO / MMIO-specific Initialization And Device O=
peration / Notifications From The Device}
> -After receiving an interrupt, the driver MUST read
> -\field{InterruptStatus} to check what caused the interrupt (see the
> -register description).  The used buffer notification bit being set
> -SHOULD be interpreted as a used buffer notification for each active
> -virtqueue.  After the interrupt is handled, the driver MUST acknowledge
> -it by writing a bit mask corresponding to the handled events to the
> -InterruptACK register.
> +A driver MUST handle the case where MSI is disabled, which uses the same=
 interrupt indicating both device configuration
> +space change and one or more virtqueues being used.
> +
> +\subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Op=
tions / Virtio Over MMIO / MMIO-specific Initialization And Device Operatio=
n / Driver Handling Interrupts}
> +
> +The driver interrupt handler would typically:
> +
> +\begin{itemize}
> +  \item If MSI is enabled:
> +    \begin{itemize}
> +      \item
> +        Figure out the virtqueue mapped to that MSI vector for the
> +        device, to see if any progress has been made by the device
> +        which requires servicing.
> +      \item
> +        If the interrupt belongs to configuration space changing signal,
> +        re-examine the configuration space to see what changed.
> +    \end{itemize}
> +  \item If MSI is disabled:
> +    \begin{itemize}
> +      \item Read \field{InterruptStatus} to check what caused the interr=
upt.
> +      \item Acknowledge the interrupt by writing a bit mask correspondin=
g
> +            to the handled events to the InterruptACK register.
> +    \end{itemize}
> +\end{itemize}
> =20
>  \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virti=
o Over MMIO / Legacy interface}
> =20
> diff --git a/msi-state.c b/msi-state.c
> new file mode 100644
> index 0000000..b1fa0c1
> --- /dev/null
> +++ b/msi-state.c
> @@ -0,0 +1,4 @@
> +le32 {
> +    msi_enabled : 1;
> +    reserved : 31;
> +};
> --=20
> 2.7.4
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


