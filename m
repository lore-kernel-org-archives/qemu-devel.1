Received: from eggs.gnu.org ([2001:4830:134:3::10]:37317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=463712e83=anthony.perard@citrix.com>)
	id 1e730w-0006Ri-6Q
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=463712e83=anthony.perard@citrix.com>)
	id 1e730s-0005Dp-63
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:29:18 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:41166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=463712e83=anthony.perard@citrix.com>)
	id 1e730r-0005D6-UX
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:29:14 -0400
Date: Tue, 24 Oct 2017 18:29:11 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171024172911.GH1885@perard.uk.xensource.com>
References: <23017.64539.31230.43449@mariner.uk.xensource.com>
	<1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
	<1508506702-17704-7-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1508506702-17704-7-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH v5.1 7/8] os-posix: Provide new -runas
 <uid>:<gid> facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Fri, Oct 20, 2017 at 02:38:21PM +0100, Ian Jackson wrote:
> +static bool os_parse_runas_uid_gid(const char *optarg)
> +{
> +    unsigned long lv;
> +    char *ep;
> +    uid_t got_uid;
> +    gid_t got_gid;
> +    int rc;
> +
> +    errno = 0;
> +    lv = strtoul(optarg, &ep, 0); /* can't qemu_strtoul, want *ep==':' */

Should strtoul base be 10? If that matter.

> +    got_uid = lv; /* overflow here is ID in C99 */
> +    if (errno || *ep != ':' || got_uid != lv || got_uid == (uid_t)-1) {
> +        return false;
> +    }
> +
> +    lv = 0;
> +    rc = qemu_strtoul(ep + 1, 0, 0, &lv);
> +    got_gid = lv; /* overflow here is ID in C99 */
> +    if (rc || got_gid != lv || got_gid == (gid_t)-1) {
> +        return false;
> +    }
> +
> +    user_uid = got_uid;
> +    user_gid = got_gid;
> +    return true;
> +}
> +
>  /*
>   * Parse OS specific command line options.
>   * return 0 if option handled, -1 otherwise
> @@ -145,8 +175,10 @@ void os_parse_cmd_args(int index, const char *optarg)
>  #endif
>      case QEMU_OPTION_runas:
>          user_pwd = getpwnam(optarg);
> -        if (!user_pwd) {
> -            fprintf(stderr, "User \"%s\" doesn't exist\n", optarg);
> +        if (!user_pwd && !os_parse_runas_uid_gid(optarg)) {
> +            fprintf(stderr,
> +                    "User \"%s\" doesn't exist (and is not <uid>.<gid>)\n",

The error message have not been update, I think it should be <uid>:<gid>

> +                    optarg);
>              exit(1);
>          }
>          break;

With the error message fix:
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
