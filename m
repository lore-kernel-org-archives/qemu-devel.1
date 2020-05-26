Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A05C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424FF2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6OQLWI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424FF2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUpp-0000HI-9Z
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 04:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdUn9-0004Bq-Nk
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:18:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41365
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdUn7-00072i-8I
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590481107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pqr2X9hmGUi+6pud1TNoRJ0/wlJhnttbloos6bQARdY=;
 b=a6OQLWI8FSVA+E0o0uzbrvnWfKsApV7i6/0UHVgt97qAhV6e2EdNOW4KJn+BQEIC3cEXWm
 VVW9admFWiVSJpd+z7Nvp/UtmRl0rTw90ZciNLoQva+9TQrcP7/SfCDIgZ34mp9y+ibicS
 9pemHECta3ASqwgMKNMmeZV3H7mgosU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-Ko1rMqYvPJmya6bnVmgXDg-1; Tue, 26 May 2020 04:18:26 -0400
X-MC-Unique: Ko1rMqYvPJmya6bnVmgXDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F96580183C;
 Tue, 26 May 2020 08:18:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9077D5D9E5;
 Tue, 26 May 2020 08:18:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 21F98113864A; Tue, 26 May 2020 10:18:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 9/9] qapi/misc: Restrict device memory commands to
 machine code
References: <20200525150640.30879-1-philmd@redhat.com>
 <20200525150640.30879-10-philmd@redhat.com>
Date: Tue, 26 May 2020 10:18:17 +0200
In-Reply-To: <20200525150640.30879-10-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 25 May 2020 17:06:40
 +0200")
Message-ID: <87h7w36ree.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael
 S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: Markus Armbruster <armbru@redhat.com>

All patches: drop the /misc from qapi/misc: in the title, if you don't
mind.

Observation:
                            before series           after
    machine-target.json     14KiB in 325 lines      15KiB in 370 lines
    machine.json            24KiB in 933 lines      43KiB in 1652 lines
    misc.json               38KiB in 1552 lines     18KiB in 796 lines

machine.json is becoming too big.  Can we move some parts to new modules
instead?  Bonus: these modules can then be covered properly in
MAINTAINERS, unlike the machine.json grabbag.

Obvious candidates for moving to new modules:

* PATCH 8 PCI (304 lines)

  This stuff belongs to MAINTAINERS section "PCI".

  Michael, Marcel, any objections to new qapi/pci.json?

  The QMP command code already lives in hw/pci/pci.c: qmp_query_pci().
  Elsewhere, we keep QMP command code in files named like
  hw/pci/pci-qmp-cmds.c, but that's probably overkill for just one
  command.

* PATCH 7 ACPI (154 lines)

  This stuff belongs to MAINTAINERS section "ACPI/SMBIOS", I think.

  Michael, Igor, any objections to new qapi/acpi.json?

  The QMP command code lives in monitor/qmp-cmds.c:
  qmp_query_acpi_ospm_status().  If we move the schema part to
  acpi.json, we should consider moving the C part to hw/acpi/.

* PATCH 9 memory (131 lines)

  MAINTAINERS section?  include/hw/mem/memory-device.h is not covered.
  hw/mem/memory-device.c is under "ACPI/SMBIOS".

  Michael, Igor, should this stuff go into acpi.json, too?

  The QMP command code lives in monitor/qmp-cmds.c:
  qmp_query_memory_size_summary().  If we move the schema part to
  acpi.json, we should consider moving the C part to hw/acpi/.

* Any others?


