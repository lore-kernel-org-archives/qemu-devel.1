Received: from eggs.gnu.org ([2001:4830:134:3::10]:38864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOkqX-0001rU-0j
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOkqS-0004R9-QA
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:16:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46552 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fOkqS-0004Qe-KH
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:15:56 -0400
References: <cover.1527814874.git.keno@juliacomputing.com>
	<1f6bc60305b8c1cd00f5e2a361a05d7b4bc56338.1527814874.git.keno@juliacomputing.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09d916f2-491c-fb8b-c42e-34814eaaf447@redhat.com>
Date: Fri, 1 Jun 2018 09:15:55 -0500
MIME-Version: 1.0
In-Reply-To: <1f6bc60305b8c1cd00f5e2a361a05d7b4bc56338.1527814874.git.keno@juliacomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/20] cutils: Provide strchrnul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>, qemu-devel@nongnu.org
Cc: groug@kaod.org

On 05/31/2018 08:25 PM, Keno Fischer wrote:
> strchrnul is a GNU extension and thus unavailable on a number of targets.
> In the review for a commit removing strchrnul from 9p, I was asked to
> create a qemu_strchrnul helper to factor out this functionality.
> Do so, and use it in a number of other places in the code base that inlined
> the replacement pattern in a place where strchrnul could be used.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
> 

> +++ b/util/cutils.c
> @@ -545,6 +545,19 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
>   }
>   
>   /**
> + * Searches for the first occurrence of 'c' in 's', and returns a pointer
> + * to the trailing null byte if none was found.
> + */
> +const char *qemu_strchrnul(const char *s, int c)
> +{
> +    const char *e = strchr(s, c);
> +    if (!e) {
> +        e = s + strlen(s);
> +    }
> +    return e;
> +}

This is twice as slow on glibc systems when the pointer to NUL is 
returned (because it has to traverse the string twice); it's better to 
have a configure check for whether strchrnul exists, and if so, use that 
directly.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
