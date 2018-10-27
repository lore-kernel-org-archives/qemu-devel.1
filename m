Received: from eggs.gnu.org ([2001:4830:134:3::10]:44886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gGMve-0007pU-6g
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 07:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gGMvd-0005jI-Hk
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 07:38:54 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:37526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gGMvd-0005iN-B5
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 07:38:53 -0400
Date: Sat, 27 Oct 2018 13:38:49 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181027113849.hrwt5uai7m55urwp@function>
References: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
	<1540512223-21199-5-git-send-email-max7255@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540512223-21199-5-git-send-email-max7255@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH RFC 4/4] net/slirp: add ipv6-hostfwd option
 for user netdev type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxim Samoylov <max7255@yandex-team.ru>
Cc: qemu-devel@nongnu.org

Maxim Samoylov, le ven. 26 oct. 2018 03:03:43 +0300, a ecrit:
> +void hmp_ipv6_hostfwd_remove(Monitor *mon, const QDict *qdict)
> +{

Similarly, a lot can be shared, by introducing 

const char *hmp_hostfwd_lookup(Monitor *mon, const QDict *qdict, int is_v6)

which will contain all the lookup and tcp/udp parsing part, and
just return the src_str (is_v6 to avoid testing only arg1).
hmp_hostfwd_remove and hmp_ipv6_hostfwd_remove can then just start by
calling it and get src_str that it can then use to parse the IPs.

> +    struct in6_addr host_addr = in6addr_any;
> +    if (*(p++) != '[') {
> +        goto fail_syntax;
> +    }

As mentioned, better explicit this in the helper message.

> +static int slirp_ipv6_hostfwd(SlirpState *s, const char *redir_str,
> +                              Error **errp)

For this one I wouldn't bother factorizing, though.

Samuel
