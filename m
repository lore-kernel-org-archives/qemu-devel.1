Received: from eggs.gnu.org ([2001:4830:134:3::10]:56950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQCwW-00055j-Nu
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQCwS-0006fB-OK
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:23:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dQCwS-0006er-Hy
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:23:36 -0400
Date: Wed, 28 Jun 2017 14:23:29 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170628132329.GJ29134@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<d7c1b8ff9247a09e54110abe6abe93543d59b8b6.1498654240.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7c1b8ff9247a09e54110abe6abe93543d59b8b6.1498654240.git.maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v6 3/4] net/net: Convert parse_host_port()
 to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, armbru@redhat.com

On Wed, Jun 28, 2017 at 09:08:49PM +0800, Mao Zhongyi wrote:
> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
> index 5c326db..78e2b30 100644
> --- a/include/qemu/sockets.h
> +++ b/include/qemu/sockets.h

>          if (qemu_isdigit(buf[0])) {
> -            if (!inet_aton(buf, &saddr->sin_addr))
> +            if (!inet_aton(buf, &saddr->sin_addr)) {
> +                error_setg(errp, "host address '%s' is not a valid "
> +                           "IPv4 address", buf);
>                  return -1;
> +            }
>          } else {
> -            if ((he = gethostbyname(buf)) == NULL)
> +            he = gethostbyname(buf);
> +            if (he == NULL) {
> +                error_setg(errp, "can't resolve host address '%s': "
> +                           "unknown host", buf);
>                  return - 1;
> +            }

gethostbyname sets  'h_errno' on failure, so you should pass that
into error_setg_errno, instead of hardcoding 'unknown host' as a
message


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
