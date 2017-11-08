Received: from eggs.gnu.org ([2001:4830:134:3::10]:46138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eCT5P-0006gB-Sb
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eCT5K-0008JV-03
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:20:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eCT5J-0008Ip-B6
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:20:13 -0500
Date: Wed, 8 Nov 2017 17:20:11 +0100
From: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20171108162011.GB13150@boraha>
References: <1510016336-4086-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510016336-4086-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] tpm: Match frontend and backend buffer
 sizes (not 2.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, amarnath.valluri@intel.com

On Mon, Nov 06, 2017 at 07:58:51PM -0500, Stefan Berger wrote:
> This patch series does away with the hard coded buffer size in the TIS
> frontend and instead retrieves the buffer size from the device that's
> being used. So it gets it from the host device or the external emulator.
> In case the frontend (CRB) cannot support the backend's current buffer size
> (typically 4k) it can adjust the buffer size the emulator is working with
> so that we will not run into the problem that the backend produces packets
> that the frontend cannot deliver to due mismatching buffer sizes.
> 

The approach looks ok to me. I don't have enough TPM/backend knowledge
to say how relevant that is in the long run. Modifying the CRB device
to set the buffer size to qemu CRB_CTRL_CMD_SIZE works. Windows 10 seems
happy at least.

Just a few remarks, I suppose you'll send a v2 soon,

thanks

>    Stefan
> 
> Stefan Berger (5):
>   tpm: Move getting TPM buffer size to backends
>   tpm: pull tpm_util_send() out of tpm_util_test()
>   tpm: tpm_passthrough: Read the buffer size from the host device
>   tpm: tpm_emulator: get and set buffer size of device
>   tpm: tpm_passthrough: Fail startup if FE buffer size < BE buffer size
> 
>  backends/tpm.c               |  13 +++-
>  hw/tpm/tpm_emulator.c        |  83 +++++++++++++++++++++++-
>  hw/tpm/tpm_int.h             |   9 +++
>  hw/tpm/tpm_ioctl.h           |  28 +++++++-
>  hw/tpm/tpm_passthrough.c     |  30 +++++++++
>  hw/tpm/tpm_tis.c             |  18 +++---
>  hw/tpm/tpm_util.c            | 149 +++++++++++++++++++++++++++++++++++++++++--
>  hw/tpm/tpm_util.h            |   3 +
>  include/sysemu/tpm_backend.h |  17 ++++-
>  9 files changed, 327 insertions(+), 23 deletions(-)
> 
> -- 
> 2.5.5
> 
> 
