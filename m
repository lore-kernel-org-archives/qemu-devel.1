Received: from eggs.gnu.org ([2001:4830:134:3::10]:46235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gHrwP-0005uM-L4
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gHrwO-0001hQ-Ts
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:57:53 -0400
References: <20181031053920.7565-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1d819a62-3fb0-d039-4cda-0b0a542979e3@redhat.com>
Date: Wed, 31 Oct 2018 09:57:25 -0500
MIME-Version: 1.0
In-Reply-To: <20181031053920.7565-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: Use error API properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 10/31/18 12:39 AM, Fam Zheng wrote:
> Use error_report for situations that affect user operation (i.e.  we're
> actually returning error), and warn_report/warn_report_err when some
> less critical error happened but the user operation can still carry on.
> 
> For raw_normalize_devicepath, add Error parameter to propagate to
> its callers.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> 

> @@ -214,8 +214,7 @@ static int raw_normalize_devicepath(const char **filename)
>       fname = *filename;
>       dp = strrchr(fname, '/');
>       if (lstat(fname, &sb) < 0) {
> -        fprintf(stderr, "%s: stat failed: %s\n",
> -            fname, strerror(errno));
> +        error_setg(errp, "%s: stat failed: %s", fname, strerror(errno));
>           return -errno;

error_setg_errno() is nicer here.  In fact, should we have a Coverity 
script that looks for error_setg(... strerror())?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
