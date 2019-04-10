Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3526C10F0E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C352A20857
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C352A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51537 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE1oN-00060Y-2Z
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 21:13:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hE1nc-0005hh-7O
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hE1nS-0002bB-F0
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:13:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:60193)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hE1nR-0002By-0t
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:13:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Apr 2019 18:12:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,331,1549958400"; d="scan'208";a="134419586"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga006.jf.intel.com with ESMTP; 09 Apr 2019 18:12:50 -0700
Date: Wed, 10 Apr 2019 09:12:31 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190410011231.GA29083@richard>
References: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.136
Subject: Re: [Qemu-devel] [PATCH for-4.1] q35: acpi: do not create dummy
 MCFG table
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: ehabkost@redhat.com, richardw.yang@linux.intel.com, qemu-devel@nongnu.org,
	mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410011231.0b3jqgJC2sBAE5K1M7MPR5SinCcUCsq5g4nYIT8WFfU@z>

On Tue, Apr 09, 2019 at 05:00:37PM +0200, Igor Mammedov wrote:
>Dummy table (with signature "QEMU") creation came from original SeaBIOS
>codebase. And QEMU would have to keep it around if there were Q35 machine
>that depended on keeping ACPI tables blob constant size. Luckily there
>were no versioned Q35 machine types before commit:
>  (since 2.3) a1666142db acpi-build: make ROMs RAM blocks resizeable
>which obsoleted need to keep ACPI tables blob the same size on source/destination.
>

I am not sure getting the "versioned Q35" correctly. Seems originally there is
q35-1.4?

commit bf3caa3dc17552b323cec6831301a22cfc98ecd5
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri Feb 8 14:06:15 2013 +0100

    pc: add compatibility machine types for 1.4
    
    Adds both pc-i440fx-1.4 and pc-q35-1.4.



-- 
Wei Yang
Help you, Help me

