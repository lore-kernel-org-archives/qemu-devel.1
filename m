Received: from eggs.gnu.org ([2001:4830:134:3::10]:41243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dYFte-0004iu-O3
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dYFtb-0003pm-Ip
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:09:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46456
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dYFtb-0003or-DK
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:09:55 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6KI9nS6056815
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 14:09:54 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2btwaccf25-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 14:09:51 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 20 Jul 2017 14:08:44 -0400
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 20 Jul 2017 20:08:36 +0200
MIME-Version: 1.0
In-Reply-To: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <a446cab4-a4f2-a20f-7a4b-122cb59166ef@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] Use qemu_tolower() and
 qemu_toupper(), not tolower() and toupper()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org

On 07/20/2017 06:31 PM, Peter Maydell wrote:
> On NetBSD, where tolower() and toupper() are implemented using an
> array lookup, the compiler warns if you pass a plain 'char'
> to these functions:
> 
> gdbstub.c:914:13: warning: array subscript has type 'char'
> 
> This reflects the fact that toupper() and tolower() give
> undefined behaviour if they are passed a value that isn't
> a valid 'unsigned char' or EOF.
> 
> We have qemu_tolower() and qemu_toupper() to avoid this problem;
> use them.
> 
> (The use in scsi-generic.c does not trigger the warning because
> it passes a uint8_t; we switch it anyway, for consistency.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com> for the s390 part.
> ---
>  gdbstub.c                  | 2 +-
>  hw/s390x/s390-virtio-ccw.c | 2 +-
>  hw/scsi/scsi-generic.c     | 2 +-
>  target/ppc/monitor.c       | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index f936ddd..2a94030 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -911,7 +911,7 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
> 
>          cur_action = *p++;
>          if (cur_action == 'C' || cur_action == 'S') {
> -            cur_action = tolower(cur_action);
> +            cur_action = qemu_tolower(cur_action);
>              res = qemu_strtoul(p + 1, &p, 16, &tmp);
>              if (res) {
>                  goto out;
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index ce3921e..1c7af39 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -318,7 +318,7 @@ static void machine_set_loadparm(Object *obj, const char *val, Error **errp)
>      int i;
> 
>      for (i = 0; i < sizeof(ms->loadparm) && val[i]; i++) {
> -        uint8_t c = toupper(val[i]); /* mimic HMC */
> +        uint8_t c = qemu_toupper(val[i]); /* mimic HMC */
> 
>          if (('A' <= c && c <= 'Z') || ('0' <= c && c <= '9') || (c == '.') ||
>              (c == ' ')) {
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index a55ff87..7e1cbab 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -406,7 +406,7 @@ static int read_naa_id(const uint8_t *p, uint64_t *p_wwn)
>          }
>          *p_wwn = 0;
>          for (i = 8; i < 24; i++) {
> -            char c = toupper(p[i]);
> +            char c = qemu_toupper(p[i]);
>              c -= (c >= '0' && c <= '9' ? '0' : 'A' - 10);
>              *p_wwn = (*p_wwn << 4) | c;
>          }
> diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
> index b8f30e9..1491511 100644
> --- a/target/ppc/monitor.c
> +++ b/target/ppc/monitor.c
> @@ -115,14 +115,14 @@ int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
>      CPUPPCState *env = &cpu->env;
> 
>      /* General purpose registers */
> -    if ((tolower(name[0]) == 'r') &&
> +    if ((qemu_tolower(name[0]) == 'r') &&
>          ppc_cpu_get_reg_num(name + 1, ARRAY_SIZE(env->gpr), &regnum)) {
>          *pval = env->gpr[regnum];
>          return 0;
>      }
> 
>      /* Floating point registers */
> -    if ((tolower(name[0]) == 'f') &&
> +    if ((qemu_tolower(name[0]) == 'f') &&
>          ppc_cpu_get_reg_num(name + 1, ARRAY_SIZE(env->fpr), &regnum)) {
>          *pval = env->fpr[regnum];
>          return 0;
> 
