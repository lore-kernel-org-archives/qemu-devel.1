Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBCCC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 07:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC77264DD
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 07:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="OAf0M75T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC77264DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWbaW-0002ho-LP
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 03:04:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hWbZS-0002KR-3U
	for qemu-devel@nongnu.org; Fri, 31 May 2019 03:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hWbZL-00087u-9E
	for qemu-devel@nongnu.org; Fri, 31 May 2019 03:03:18 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hWbZJ-0007yo-6O
	for qemu-devel@nongnu.org; Fri, 31 May 2019 03:03:13 -0400
Received: by mail-pf1-x444.google.com with SMTP id a23so5618067pff.4
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 00:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=MNASbWlECMfvlLpWkl4aGVbyYYqeiqS8/zcZjtEqj1U=;
	b=OAf0M75TT9eSxTvhOO7I7tbhNTzfDJqUshtESMp3wGtYTfvtg1YD1QEVmMfkEPPWK9
	4aj5SLBl9n2puQoERrODwtE1wouIQ0sZjYBdVSO2GqwcQZfN3bkRC4WX8exF3fcFgs+w
	rdg9Z5UoZlTb4GDsGDQ1gZ+xphSUfk/la8ash7g+GyqcoHrf16FeqQuPXk+q8aXdT86K
	9YChoUdrbA2/Q+tQEcUuVwVoKA4CTfE9R/HOGHUUPptqNvLIvhtTXVZC+qt1zUC3zhI3
	NJxatO3vOv+u/UMD3MVbd/3gKX9InCyzLTuUURPROIPcHR1gk2FOIutNDwxwuYpdtNZB
	JFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=MNASbWlECMfvlLpWkl4aGVbyYYqeiqS8/zcZjtEqj1U=;
	b=uleZGEt8jyNk7zubT209C9Q0y4of8iFWumQ62RF0Ei+28PhWq4iDjX39Hcf97b8xF2
	XssC0T5ROCMOAnmcsGmrGGGLCDllY3mU7dG0IsprAMxgdD/GqTavRN/Bz98rqK7cukYb
	2lD7BHQX7UBNUjf1e4hGj/0U6jKWG+AXypkDLKAlCGcLQZDw3N2yI96ZuhypcFekmuxd
	ScNYh6KW9Qzo4vmtsGu+UQOQb7WznjWAoQDylxEKW90zRhuZ4hc4ilZu+h+x6nvjxOF8
	cNBdeBLJ4mMzOJ+2KMOZXFZvUQ92cfOnhUotjDO9rqjJmSySdKTamw+vvMXwSNUZu0gQ
	crAA==
X-Gm-Message-State: APjAAAUZxvA4KDe5oCQBXCShygk3eIHollmovQkXPkfXTCB+zh7+ONM/
	jMtRtKCHDgPIyA/Up3bD0HRMxQ==
X-Google-Smtp-Source: APXvYqzSiO3NnWjRTPojx6kuADgSFPdhz8uZuYRlOaCXnYERXet33ank86pgIjduyYZ2qVXLCBqEzg==
X-Received: by 2002:a17:90a:71cb:: with SMTP id
	m11mr7181797pjs.40.1559286190843; 
	Fri, 31 May 2019 00:03:10 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10]) by smtp.gmail.com with ESMTPSA id
	z32sm4756389pgk.25.2019.05.31.00.03.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 00:03:09 -0700 (PDT)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>
References: <20190521082411.24719-1-clg@kaod.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
	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
Message-ID: <278a8439-bba6-1f09-fe16-b2174d3e3bbe@ozlabs.ru>
Date: Fri, 31 May 2019 17:03:05 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190521082411.24719-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] docs: provide documentation
 on the POWER9 XIVE interrupt controller
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
	Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
	qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 21/05/2019 18:24, Cédric Le Goater wrote:
> This documents the overall XIVE architecture and the XIVE support for
> sPAPR guest machines (pseries).
> 
> It also provides documentation on the 'info pic' command.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
> 
>  Changes since v2:
> 
>  - fixed typos.
> 
>  Changes since v1:
> 
>  - reorganized into different files and directories. I don't think the
>    'info pic' documentation belongs to 'interop' nor 'devel' and so
>    the ppc-spapr-xive.rst file seemed like the best place for it.
>    
>  docs/index.rst                |   1 +
>  docs/specs/index.rst          |  13 +++
>  docs/specs/ppc-spapr-xive.rst | 174 +++++++++++++++++++++++++++++
>  docs/specs/ppc-xive.rst       | 199 ++++++++++++++++++++++++++++++++++
>  MAINTAINERS                   |   1 +
>  5 files changed, 388 insertions(+)
>  create mode 100644 docs/specs/index.rst
>  create mode 100644 docs/specs/ppc-spapr-xive.rst
>  create mode 100644 docs/specs/ppc-xive.rst
> 
> diff --git a/docs/index.rst b/docs/index.rst
> index 3690955dd1f5..baa5791c174b 100644
> --- a/docs/index.rst
> +++ b/docs/index.rst
> @@ -12,4 +12,5 @@ Welcome to QEMU's documentation!
>  
>     interop/index
>     devel/index
> +   specs/index
>  
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> new file mode 100644
> index 000000000000..2e927519c2e7
> --- /dev/null
> +++ b/docs/specs/index.rst
> @@ -0,0 +1,13 @@
> +. This is the top level page for the 'specs' manual
> +
> +
> +QEMU full-system emulation guest hardware specifications
> +========================================================
> +
> +
> +Contents:
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   xive
> diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rst
> new file mode 100644
> index 000000000000..539ce7ca4e90
> --- /dev/null
> +++ b/docs/specs/ppc-spapr-xive.rst
> @@ -0,0 +1,174 @@
> +XIVE for sPAPR (pseries machines)
> +=================================
> +
> +The POWER9 processor comes with a new interrupt controller
> +architecture, called XIVE as "eXternal Interrupt Virtualization
> +Engine". It supports a larger number of interrupt sources and offers
> +virtualization features which enables the HW to deliver interrupts
> +directly to virtual processors without hypervisor assistance.
> +
> +A QEMU ``pseries`` machine (which is PAPR compliant) using POWER9
> +processors can run under two interrupt modes:
> +
> +- *Legacy Compatibility Mode*
> +
> +  the hypervisor provides identical interfaces and similar
> +  functionality to PAPR+ Version 2.7.  This is the default mode
> +
> +  It is also referred as *XICS* in QEMU.
> +
> +- *XIVE native exploitation mode*
> +
> +  the hypervisor provides new interfaces to manage the XIVE control
> +  structures, and provides direct control for interrupt management
> +  through MMIO pages.
> +
> +Which interrupt modes can be used by the machine is negotiated with
> +the guest O/S during the Client Architecture Support negotiation
> +sequence. The two modes are mutually exclusive.
> +
> +Both interrupt mode share the same IRQ number space. See below for the
> +layout.
> +
> +CAS Negotiation
> +---------------
> +
> +QEMU advertises the supported interrupt modes in the device tree
> +property "ibm,arch-vec-5-platform-support" in byte 23 and the OS
> +Selection for XIVE is indicated in the "ibm,architecture-vec-5"
> +property byte 23.
> +
> +The interrupt modes supported by the machine depend on the CPU type
> +(POWER9 is required for XIVE) but also on the machine property
> +``ic-mode`` which can be set on the command line. It can take the
> +following values: ``xics``, ``xive``, ``dual`` and currently ``xics``
> +is the default but it may change in the future.
> +
> +The choosen interrupt mode is activated after a reconfiguration done
> +in a machine reset.
> +
> +XIVE Device tree properties
> +---------------------------
> +
> +The properties for the PAPR interrupt controller node when the *XIVE
> +native exploitation mode* is selected shoud contain:
> +
> +- ``device_type``
> +
> +  value should be "power-ivpe".
> +
> +- ``compatible``
> +
> +  value should be "ibm,power-ivpe".
> +
> +- ``reg``
> +
> +  contains the base address and size of the thread interrupt
> +  managnement areas (TIMA), for the User level and for the Guest OS
> +  level. Only the Guest OS level is taken into account today.
> +
> +- ``ibm,xive-eq-sizes``
> +
> +  the size of the event queues. One cell per size supported, contains
> +  log2 of size, in ascending order.
> +
> +- ``ibm,xive-lisn-ranges``
> +
> +  the IRQ interrupt number ranges assigned to the guest for the IPIs.
> +
> +The root node also exports :
> +
> +- ``ibm,plat-res-int-priorities``
> +
> +  contains a list of priorities that the hypervisor has reserved for
> +  its own use.
> +
> +IRQ number space
> +----------------
> +
> +IRQ Number space of the ``pseries`` machine is 8K wide and is the same
> +for both interrupt mode. The different ranges are defined as follow :
> +
> +- ``0x0000 .. 0x0FFF`` 4K CPU IPIs (only used under XIVE)
> +- ``0x1000 .. 0x1000`` 1 EPOW
> +- ``0x1001 .. 0x1001`` 1 HOTPLUG

"0x1002 .. 0x10FF unused" since you have "unused" below too.

> +- ``0x1100 .. 0x11FF`` 256 VIO devices
> +- ``0x1200 .. 0x127F`` 32 PHBs devices
> +- ``0x1280 .. 0x12FF`` unused
> +- ``0x1300 .. 0x1FFF`` PHB MSIs




> +
> +Monitoring XIVE
> +---------------
> +
> +The state of the XIVE interrupt controller can be queried through the
> +monitor commands ``info pic``. The output comes in two parts.
> +
> +First, the state of the thread interrupt context registers is dumped
> +for each CPU :
> +
> +::
> +
> +   (qemu) info pic
> +   CPU[0000]:   QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR  W2
> +   CPU[0000]: USER    00   00  00    00   00  00  00   00  00000000
> +   CPU[0000]:   OS    00   ff  00    00   ff  00  ff   ff  80000400
> +   CPU[0000]: POOL    00   00  00    00   00  00  00   00  00000000
> +   CPU[0000]: PHYS    00   00  00    00   00  00  00   ff  00000000
> +   ...
> +
> +In the case of a ``pseries`` machine, QEMU acts as the hypervisor and only
> +the O/S and USER register rings make sense. ``W2`` contains the vCPU CAM
> +line which is set to the VP identifier.
> +
> +Then comes the routing information which aggregates the EAS and the
> +END configuration:
> +
> +::
> +
> +   ...
> +   LISN         PQ    EISN     CPU/PRIO EQ
> +   00000000 MSI --    00000010   0/6    380/16384 @1fe3e0000 ^1 [ 80000010 ... ]
> +   00000001 MSI --    00000010   1/6    305/16384 @1fc230000 ^1 [ 80000010 ... ]
> +   00000002 MSI --    00000010   2/6    220/16384 @1fc2f0000 ^1 [ 80000010 ... ]
> +   00000003 MSI --    00000010   3/6    201/16384 @1fc390000 ^1 [ 80000010 ... ]
> +   00000004 MSI -Q  M 00000000
> +   00000005 MSI -Q  M 00000000
> +   00000006 MSI -Q  M 00000000
> +   00000007 MSI -Q  M 00000000
> +   00001000 MSI --    00000012   0/6    380/16384 @1fe3e0000 ^1 [ 80000010 ... ]
> +   00001001 MSI --    00000013   0/6    380/16384 @1fe3e0000 ^1 [ 80000010 ... ]
> +   00001100 MSI --    00000100   1/6    305/16384 @1fc230000 ^1 [ 80000010 ... ]
> +   00001101 MSI -Q  M 00000000
> +   00001200 LSI -Q  M 00000000
> +   00001201 LSI -Q  M 00000000
> +   00001202 LSI -Q  M 00000000
> +   00001203 LSI -Q  M 00000000
> +   00001300 MSI --    00000102   1/6    305/16384 @1fc230000 ^1 [ 80000010 ... ]
> +   00001301 MSI --    00000103   2/6    220/16384 @1fc2f0000 ^1 [ 80000010 ... ]
> +   00001302 MSI --    00000104   3/6    201/16384 @1fc390000 ^1 [ 80000010 ... ]
> +
> +The source information and configuration:
> +
> +- The ``LISN`` column outputs the interrupt number of the source in
> +  range ``[ 0x0 ... 0x1FFF ]`` and its type : ``MSI`` or ``LSI``
> +- The ``PQ`` column reflects the state of the PQ bits of the source :
> +
> +  - ``--`` source is ready to take events
> +  - ``P-`` an event was sent and an EOI is PENDING
> +  - ``PQ`` an event was QUEUED
> +  - ``-Q`` source is OFF
> +
> +  a ``M`` indicates that source is *MASKED* at the EAS level,
> +
> +The targeting configuration :
> +
> +- The ``EISN`` column is the event data that will be queued in the event
> +  queue of the O/S.
> +- The ``CPU/PRIO`` column is the tuple defining the CPU number and
> +  priority queue serving the source.
> +- The ``EQ`` column outputs :
> +
> +  - the current index of the event queue/ the max number of entries
> +  - the O/S event queue address


My qemu does not print these:

  00001302 MSI --    00000104   0/6  12145/16384 ^1 [ 80000107 80000107
80000107 80000107 80000107 ^00000000 ]


> +  - the toggle bit
> +  - the last entries that were pushed in the event queue.
> diff --git a/docs/specs/ppc-xive.rst b/docs/specs/ppc-xive.rst
> new file mode 100644
> index 000000000000..b997dc062910
> --- /dev/null
> +++ b/docs/specs/ppc-xive.rst
> @@ -0,0 +1,199 @@
> +================================
> +POWER9 XIVE interrupt controller
> +================================
> +
> +The POWER9 processor comes with a new interrupt controller
> +architecture, called XIVE as "eXternal Interrupt Virtualization
> +Engine".
> +
> +Compared to the previous architecture, the main characteristics of
> +XIVE are to support a larger number of interrupt sources and to
> +deliver interrupts directly to virtual processors without hypervisor
> +assistance. This removes the context switches required for the
> +delivery process.
> +
> +
> +XIVE architecture
> +=================
> +
> +The XIVE IC is composed of three sub-engines, each taking care of a
> +processing layer of external interrupts:
> +
> +- Interrupt Virtualization Source Engine (IVSE), or Source Controller
> +  (SC). These are found in PCI PHBs, in the PSI host bridge

The text suggests IVSE==SC but the picture has SC in the IVRE box, does
it mean that IVRE itself has a source or it should be "PC"?

Also out of curiosity - what is "PSI"?


> +  controller, but also inside the main controller for the core IPIs
> +  and other sub-chips (NX, CAP, NPU) of the chip/processor. They are
> +  configured to feed the IVRE with events.
> +- Interrupt Virtualization Routing Engine (IVRE) or Virtualization
> +  Controller (VC). It handles event coalescing and perform interrupt
> +  routing by matching an event source number with an Event
> +  Notification Descriptor (END).
> +- Interrupt Virtualization Presentation Engine (IVPE) or Presentation
> +  Controller (PC). It maintains the interrupt context state of each
> +  thread and handles the delivery of the external interrupt to the
> +  thread.
> +
> +::
> +
> +                XIVE Interrupt Controller
> +                +------------------------------------+      IPIs
> +                | +---------+ +---------+ +--------+ |    +-------+
> +                | |IVRE     | |Common Q | |IVPE    |----> | CORES |
> +                | |     esb | |         | |        |----> |       |
> +                | |     eas | |  Bridge | |   tctx |----> |       |
> +                | |SC   end | |         | |    nvt | |    |       |
> +    +------+    | +---------+ +----+----+ +--------+ |    +-+-+-+-+
> +    | RAM  |    +------------------|-----------------+      | | |
> +    |      |                       |                        | | |
> +    |      |                       |                        | | |
> +    |      |  +--------------------v------------------------v-v-v--+    other
> +    |      <--+                     Power Bus                      +--> chips
> +    |  esb |  +---------+-----------------------+------------------+
> +    |  eas |            |                       |
> +    |  end |         +--|------+                |
> +    |  nvt |       +----+----+ |           +----+----+
> +    +------+       |IVSE     | |           |IVSE     |
> +                   |         | |           |         |
> +                   | PQ-bits | |           | PQ-bits |
> +                   | local   |-+           |  in VC  |
> +                   +---------+             +---------+
> +                      PCIe                 NX,NPU,CAPI
> +
> +
> +    PQ-bits: 2 bits source state machine (P:pending Q:queued)
> +    esb: Event State Buffer (Array of PQ bits in an IVSE)
> +    eas: Event Assignment Structure
> +    end: Event Notification Descriptor
> +    nvt: Notification Virtual Target
> +    tctx: Thread interrupt Context registers



[aik@yc02goos ~]$ ~/s/qemu/qmp qemu.mon.user2223.6_0_0_1 hmp info mtree
| grep xive
    0006010000000000-000601003fffffff (prio 0, i/o): xive.esb
    0006010040000000-000601007fffffff (prio 0, i/o): xive.end [disabled]
    0006030203180000-00060302031bffff (prio 0, i/o): xive.tima
    0006010000000000-000601003fffffff (prio 0, i/o): xive.esb
    0006010040000000-000601007fffffff (prio 0, i/o): xive.end [disabled]
    0006030203180000-00060302031bffff (prio 0, i/o): xive.tima
    0006010000000000-000601003fffffff (prio 0, i/o): xive.esb
    0006010040000000-000601007fffffff (prio 0, i/o): xive.end [disabled]
    0006030203180000-00060302031bffff (prio 0, i/o): xive.tima


"xive.end" is always disabled, why create it then (I understand this all
very little)?


> +
> +
> +
> +XIVE internal tables
> +--------------------
> +
> +Each of the sub-engines uses a set of tables to redirect interrupts
> +from event sources to CPU threads.
> +
> +::
> +
> +                                            +-------+
> +    User or O/S                             |  EQ   |
> +        or                          +------>|entries|
> +    Hypervisor                      |       |  ..   |
> +      Memory                        |       +-------+
> +                                    |           ^
> +                                    |           |
> +               +-------------------------------------------------+
> +                                    |           |
> +    Hypervisor      +------+    +---+--+    +---+--+   +------+
> +      Memory        | ESB  |    | EAT  |    | ENDT |   | NVTT |
> +     (skiboot)      +----+-+    +----+-+    +----+-+   +------+
> +                      ^  |        ^  |        ^  |       ^
> +                      |  |        |  |        |  |       |
> +               +-------------------------------------------------+
> +                      |  |        |  |        |  |       |
> +                      |  |        |  |        |  |       |
> +                 +----|--|--------|--|--------|--|-+   +-|-----+    +------+
> +                 |    |  |        |  |        |  | |   | | tctx|    |Thread|
> +     IPI or   ---+    +  v        +  v        +  v |---| +  .. |----->     |
> +    HW events    |                                 |   |       |    |      |
> +                 |             IVRE                |   | IVPE  |    +------+
> +                 +---------------------------------+   +-------+
> +
> +
> +The IVSE have a 2-bits state machine, P for pending and Q for queued,
> +for each source that allows events to be triggered. They are stored in
> +an Event State Buffer (ESB) array and can be controlled by MMIOs.
> +
> +If the event is let through, the IVRE looks up in the Event Assignment
> +Structure (EAS) table for an Event Notification Descriptor (END)
> +configured for the source. Each Event Notification Descriptor defines
> +a notification path to a CPU and an in-memory Event Queue, in which
> +will be enqueued an EQ data for the O/S to pull.
> +
> +The IVPE determines if a Notification Virtual Target (NVT) can handle
> +the event by scanning the thread contexts of the VCPUs dispatched on
> +the processor HW threads. It maintains the interrupt context state of
> +each thread in a NVT table.
> +
> +XIVE thread interrupt context
> +-----------------------------
> +
> +The XIVE presenter can generate four different exceptions to its
> +HW threads:
> +
> +- hypervisor exception
> +- O/S exception
> +- Event-Based Branch (user level)
> +- msgsnd (doorbell)
> +
> +Each exception has a state independent from the others called a Thread
> +Interrupt Management context. This context is a set of registers which
> +lets the thread handle priority management and interrupt
> +acknowledgment among other things. The most important ones being :
> +
> +- Interrupt Priority Register  (PIPR)
> +- Interrupt Pending Buffer     (IPB)
> +- Current Processor Priority   (CPPR)
> +- Notification Source Register (NSR)
> +
> +TIMA
> +~~~~
> +
> +The Thread Interrupt Management registers are accessible through a
> +specific MMIO region, called the Thread Interrupt Management Area
> +(TIMA), four aligned pages, each exposing a different view of the
> +registers. First page (page address ending in ``0b00``) gives access
> +to the entire context and is reserved for the ring 0 view for the
> +physical thread context. The second (page address ending in ``0b01``)
> +is for the hypervisor, ring 1 view. The third (page address ending in
> +``0b10``) is for the operating system, ring 2 view. The fourth (page
> +address ending in ``0b11``) is for user level, ring 3 view.
> +
> +Interrupt flow from an O/S perspective
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +After an event data has been enqueued in the O/S Event Queue, the IVPE
> +raises the bit corresponding to the priority of the pending interrupt
> +in the register IBP (Interrupt Pending Buffer) to indicate that an
> +event is pending in one of the 8 priority queues. The Pending
> +Interrupt Priority Register (PIPR) is also updated using the IPB. This
> +register represent the priority of the most favored pending
> +notification.
> +
> +The PIPR is then compared to the the Current Processor Priority
> +Register (CPPR). If it is more favored (numerically less than), the
> +CPU interrupt line is raised and the EO bit of the Notification Source
> +Register (NSR) is updated to notify the presence of an exception for
> +the O/S. The O/S acknowledges the interrupt with a special load in the
> +Thread Interrupt Management Area.
> +
> +The O/S handles the interrupt and when done, performs an EOI using a
> +MMIO operation on the ESB management page of the associate source.
> +
> +Overview of the QEMU models for XIVE
> +====================================
> +
> +The XiveSource models the IVSE in general, internal and external. It
> +handles the source ESBs and the MMIO interface to control them.
> +
> +The XiveNotifier is a small helper interface interconnecting the
> +XiveSource to the XiveRouter.
> +
> +The XiveRouter is an abstract model acting as a combined IVRE and
> +IVPE. It routes event notifications using the EAS and END tables to
> +the IVPE sub-engine which does a CAM scan to find a CPU to deliver the
> +exception. Storage should be provided by the inheriting classes.
> +
> +XiveEnDSource is a special source object. It exposes the END ESB MMIOs
> +of the Event Queues which are used for coalescing event notifications
> +and for escalation. Not used on the field, only to sync the EQ cache
> +in OPAL.
> +
> +Finally, the XiveTCTX contains the interrupt state context of a thread,
> +four sets of registers, one for each exception that can be delivered
> +to a CPU. These contexts are scanned by the IVPE to find a matching VP
> +when a notification is triggered. It also models the Thread Interrupt
> +Management Area (TIMA), which exposes the thread context registers to
> +the CPU for interrupt management.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9424a490d647..82ac0415b493 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1708,6 +1708,7 @@ L: qemu-ppc@nongnu.org
>  S: Supported
>  F: hw/*/*xive*
>  F: include/hw/*/*xive*
> +F: docs/*/*xive*
>  
>  Subsystems
>  ----------
> 

-- 
Alexey

