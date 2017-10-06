Received: from eggs.gnu.org ([2001:4830:134:3::10]:53154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=44597b5a6=ross.lagerwall@citrix.com>)
	id 1e0S8s-0000Do-AM
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=44597b5a6=ross.lagerwall@citrix.com>)
	id 1e0S8o-0004B7-BA
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:54:14 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:25040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=44597b5a6=ross.lagerwall@citrix.com>)
	id 1e0S8o-00049G-55
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:54:10 -0400
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507133891-26013-8-git-send-email-ian.jackson@eu.citrix.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <5e5b3443-eb6f-de15-2cd6-35b5c9cf084a@citrix.com>
Date: Fri, 6 Oct 2017 13:47:31 +0100
MIME-Version: 1.0
In-Reply-To: <1507133891-26013-8-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@nongnu.org

On 10/04/2017 05:18 PM, Ian Jackson wrote:
> This allows the caller to specify a uid and gid to use, even if there
> is no corresponding password entry.  This will be useful in certain
> Xen configurations.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
snip
> @@ -166,17 +187,19 @@ void os_parse_cmd_args(int index, const char *optarg)
>   
>   static void change_process_uid(void)
>   {
> -    if (user_pwd) {
> -        if (setgid(user_pwd->pw_gid) < 0) {
> +    if (user_pwd || user_uid != (uid_t)-1) {
> +        if (setgid(user_pwd ? user_pwd->pw_gid : user_gid) < 0) {
>               fprintf(stderr, "Failed to setgid(%d)\n", user_pwd->pw_gid);
>               exit(1);
>           }
> -        if (initgroups(user_pwd->pw_name, user_pwd->pw_gid) < 0) {
> +        if ((user_pwd
> +             ? initgroups(user_pwd->pw_name, user_pwd->pw_gid)
> +             : setgroups(1, &user_gid)) < 0) {
>               fprintf(stderr, "Failed to initgroups(\"%s\", %d)\n",
>                       user_pwd->pw_name, user_pwd->pw_gid);
>               exit(1);
>           }
> -        if (setuid(user_pwd->pw_uid) < 0) {
> +        if (setuid(user_pwd ? user_pwd->pw_uid : user_gid) < 0) {
>               fprintf(stderr, "Failed to setuid(%d)\n", user_pwd->pw_uid);
>               exit(1);
>           }

This last one should be user_uid, not user_gid.

-- 
Ross Lagerwall
