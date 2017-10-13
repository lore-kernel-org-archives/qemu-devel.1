Received: from eggs.gnu.org ([2001:4830:134:3::10]:41472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2xqh-00005N-CC
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2xqe-00089v-5N
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:09:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e2xqd-00088s-S1
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:09:48 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9DB9ehr031610
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:09:41 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2djtynd8m6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:09:40 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 13 Oct 2017 05:09:35 -0600
References: <1507751249-3035-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 13 Oct 2017 07:09:32 -0400
MIME-Version: 1.0
In-Reply-To: <1507751249-3035-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <b8b2952b-0416-ecc1-6fef-a4d118fab536@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] tpm: Use EMSGSIZE instead of EBADMSG to
 compile on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarnath.valluri@intel.com, marcandre.lureau@gmail.com

On 10/11/2017 03:47 PM, Stefan Berger wrote:
> EBADMSG was only added to OpenBSD very recently. To make QEMU compilable
> on older OpenBSD versions use EMSGSIZE instead when a mismatch between
> number of received bytes and message size indicated in the header was
> found.
>
> Return -EMSGSIZE and convert all other errnos in the same functions to
> return the negative errno.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Can someone have a look at this, please?

    Stefan

> ---
>   hw/tpm/tpm_util.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index fb929f6..73d7796 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -68,10 +68,10 @@ static int tpm_util_test(int fd,
>
>       n = write(fd, request, requestlen);
>       if (n < 0) {
> -        return errno;
> +        return -errno;
>       }
>       if (n != requestlen) {
> -        return EFAULT;
> +        return -EFAULT;
>       }
>
>       FD_ZERO(&readfds);
> @@ -80,18 +80,18 @@ static int tpm_util_test(int fd,
>       /* wait for a second */
>       n = select(fd + 1, &readfds, NULL, NULL, &tv);
>       if (n != 1) {
> -        return errno;
> +        return -errno;
>       }
>
>       n = read(fd, &buf, sizeof(buf));
>       if (n < sizeof(struct tpm_resp_hdr)) {
> -        return EFAULT;
> +        return -EFAULT;
>       }
>
>       resp = (struct tpm_resp_hdr *)buf;
>       /* check the header */
>       if (be32_to_cpu(resp->len) != n) {
> -        return EBADMSG;
> +        return -EMSGSIZE;
>       }
>
>       *return_tag = be16_to_cpu(resp->tag);
