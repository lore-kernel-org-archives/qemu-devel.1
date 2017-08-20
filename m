Received: from eggs.gnu.org ([2001:4830:134:3::10]:33707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1djKw3-0005rr-MI
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 03:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1djKw0-0006p3-HG
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 03:46:15 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:40337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1djKw0-0006Yl-9d
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 03:46:12 -0400
Received: from player763.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id A272B7648D
	for <qemu-devel@nongnu.org>; Sun, 20 Aug 2017 09:46:02 +0200 (CEST)
References: <1503178840-21512-1-git-send-email-minyard@acm.org>
	<1503178840-21512-2-git-send-email-minyard@acm.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ffb62325-a4f0-c438-a38b-4d63f76ee163@kaod.org>
Date: Sun, 20 Aug 2017 09:45:57 +0200
MIME-Version: 1.0
In-Reply-To: <1503178840-21512-2-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] ipmi: Fix SEL get/set time commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <cminyard@mvista.com>

On 08/19/2017 11:40 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> The minimum message size was wrong for both commands, for getting
> the time it's zero and for setting the time it's 4.  And the data
> was being pulled from the wrong place in the set time message, it
> should be the first four bytes.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  hw/ipmi/ipmi_bmc_sim.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 277c28c..1c732aa 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -1571,7 +1571,7 @@ static void set_sel_time(IPMIBmcSim *ibs,
>      uint32_t val;
>      struct ipmi_time now;
>  
> -    val = cmd[2] | (cmd[3] << 8) | (cmd[4] << 16) | (cmd[5] << 24);
> +    val = cmd[0] | (cmd[1] << 8) | (cmd[2] << 16) | (cmd[3] << 24);

I am confused. I thought cmd[0] and cmd[1] were the 'netfun' and 
'cmd' bytes, data beginning at byte 2. Isn't it the case for this
command also ? 

C.


>      ipmi_gettime(&now);
>      ibs->sel.time_offset = now.tv_sec - ((long) val);
>  }
> @@ -1802,8 +1802,8 @@ static const IPMICmdHandler storage_cmds[] = {
>      [IPMI_CMD_GET_SEL_ENTRY] = { get_sel_entry, 8 },
>      [IPMI_CMD_ADD_SEL_ENTRY] = { add_sel_entry, 18 },
>      [IPMI_CMD_CLEAR_SEL] = { clear_sel, 8 },
> -    [IPMI_CMD_GET_SEL_TIME] = { get_sel_time, 6 },
> -    [IPMI_CMD_SET_SEL_TIME] = { set_sel_time },
> +    [IPMI_CMD_GET_SEL_TIME] = { get_sel_time },
> +    [IPMI_CMD_SET_SEL_TIME] = { set_sel_time, 4 },
>  };
>  
>  static const IPMINetfn storage_netfn = {
> 
