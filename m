Received: from eggs.gnu.org ([2001:4830:134:3::10]:39035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f102b-0008FS-W3
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 21:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f102Y-0001AD-SJ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 21:38:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f102Y-0001A1-Ni
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 21:38:14 -0400
Date: Wed, 28 Mar 2018 09:38:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180328013804.GM31422@lemon.usersys.redhat.com>
References: <20180327211451.14647-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327211451.14647-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] hw/scsi: support SCSI-2 passthrough
 without PI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, 03/27 18:14, Daniel Henrique Barboza wrote:
> QEMU SCSI code makes assumptions about how the PROTECT and BYTCHK
> works in the protocol, denying support for PI (Protection
> Information) in case the guest OS requests it. However, in SCSI versions 2
> and older, there is no PI concept in the protocol.
> 
> This means that when dealing with such devices:
> 
> - there is no PROTECT bit in byte 5 of the standard INQUIRY response. The
> whole byte is marked as "Reserved";
> 
> - there is no RDPROTECT in byte 2 of READ. We have 'Logical Unit Number'
> in this field instead;
> 
> - there is no VRPROTECT in byte 2 of VERIFY. We have 'Logical Unit Number'
> in this field instead. This also means that the BYTCHK bit in this case
> is not related to PI.
> 
> Since QEMU does not consider these changes, a SCSI passthrough using
> a SCSI-2 device will not work. It will mistake these fields with
> PI information and return Illegal Request SCSI SENSE thinking
> that the driver is asking for PI support.
> 
> This patch fixes it by adding a new attribute called 'scsi_version'
> that is read from the standard INQUIRY response of passthrough
> devices. This allows for a version verification before applying
> conditions related to PI that doesn't apply for older versions.
> 
> Reported-by: Dac Nguyen <dacng@us.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
> 
> Changes in v3:
> - moved the scsi_version initialization from realize functions to
> reset functions, allowing the scsi_version to be redefined again after
> each reboot.

Reviewed-by: Fam Zheng <famz@redhat.com>
