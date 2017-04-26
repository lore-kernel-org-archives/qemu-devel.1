Received: from eggs.gnu.org ([2001:4830:134:3::10]:52316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3Lm1-0001rT-FJ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3Lm0-0002rc-F4
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:10:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d3Lm0-0002rR-5N
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:10:20 -0400
Date: Wed, 26 Apr 2017 13:10:13 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170426121013.GR18933@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
	<1492845627-4384-13-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1492845627-4384-13-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3 12/18] crypto: introduce some common
 functions for af_alg backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: arei.gonglei@huawei.com, longpeng.mike@gmail.com, qemu-devel@nongnu.org, weidong.huang@huawei.com

On Sat, Apr 22, 2017 at 03:20:21PM +0800, Longpeng(Mike) wrote:
> The AF_ALG socket family is the userspace interface for linux
> crypto API, this patch adds af_alg family support and some common
> functions for af_alg backend. It'll be used by afalg-backend crypto
> latter.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  configure            |  21 +++++++++
>  crypto/Makefile.objs |   1 +
>  crypto/afalg.c       | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  crypto/afalgpriv.h   |  59 ++++++++++++++++++++++++++
>  4 files changed, 199 insertions(+)
>  create mode 100644 crypto/afalg.c
>  create mode 100644 crypto/afalgpriv.h

> +static bool
> +qcrypto_afalg_build_saddr(const char *type, const char *name,
> +                          struct sockaddr_alg *salg, Error **errp)
> +{
> +    salg->salg_family = AF_ALG;
> +
> +    if (qemu_strnlen(type, SALG_TYPE_LEN_MAX) == SALG_TYPE_LEN_MAX) {
> +        error_setg(errp, "Afalg type(%s) is larger than %d bytes",
> +                   type, SALG_TYPE_LEN_MAX);
> +        return false;
> +    }
> +
> +    if (qemu_strnlen(name, SALG_NAME_LEN_MAX) == SALG_NAME_LEN_MAX) {
> +        error_setg(errp, "Afalg name(%s) is larger than %d bytes",
> +                   name, SALG_NAME_LEN_MAX);
> +        return false;
> +    }

This is uneccessarily complicated - we can just use

   if (strlen(name) >= SALG_NAME_LEN_MAX) {
       ....
   }

> +    pstrcpy((char *)salg->salg_type, SALG_TYPE_LEN_MAX, type);
> +    pstrcpy((char *)salg->salg_name, SALG_NAME_LEN_MAX, name);
> +
> +    return true;
> +}


> +void qcrypto_afalg_comm_free(QCryptoAFAlg *afalg)
> +{
> +    if (afalg) {

Rather than indenting the entire method it is preferrable to
invert the condition and return immediately, eg

  if (!afalg) {
     return;
  }

> +        if (afalg->msg) {
> +            g_free(afalg->msg->msg_control);
> +            g_free(afalg->msg);
> +        }
> +
> +        if (afalg->name) {
> +            g_free(afalg->name);
> +        }
> +
> +        if (afalg->tfmfd != -1) {
> +            closesocket(afalg->tfmfd);
> +        }
> +
> +        if (afalg->opfd != -1) {
> +            closesocket(afalg->opfd);
> +        }
> +
> +        g_free(afalg);
> +    }
> +}


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
