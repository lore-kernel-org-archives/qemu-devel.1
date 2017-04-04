Received: from eggs.gnu.org ([2001:4830:134:3::10]:45735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cvXxV-0003Ci-9R
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cvXxR-0002XL-AW
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:33:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47062
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cvXxR-0002X5-4J
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:33:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v34NXeVo078734
	for <qemu-devel@nongnu.org>; Tue, 4 Apr 2017 19:33:52 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29m24bfmpx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 19:33:51 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 4 Apr 2017 17:33:51 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170321141435.23701-1-sameeh@daynix.com>
References: <20170321141435.23701-1-sameeh@daynix.com>
Date: Tue, 04 Apr 2017 17:55:47 -0500
Message-Id: <149134654744.1924.4586865323465702075@loki>
Subject: Re: [Qemu-devel] [PATCH qemu-ga] qemu-ga: Don't display errors to
 the user on thaw command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>

Quoting Sameeh Jubran (2017-03-21 09:14:35)
> Errors that are related to ur inner implementation for the thaw command
> shouldn't be displayed to the user.
> =

> Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
> ---
>  qga/vss-win32/requester.cpp | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 0cd2f0e..272e71b 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -463,7 +463,7 @@ void requester_thaw(int *num_vols, ErrorSet *errset)
>              hr =3D WaitForAsync(pAsync);
>          }
>          if (FAILED(hr)) {
> -            err_set(errset, hr, "failed to complete backup");

We cannot do this. If the freeze operation didn't successfully maintain
the frozen state for entire duration we *must* report an error to the
user, otherwise users have no way to know that their snapshot might be
completely corrupted. Well, I suppose they can look at
guest-fsfreeze-thaw's return value and check that it matches the number
of volumes that were originally frozen, but that aspect is intended as a
sanity check to identify situations outside of qemu-ga's control, like
another user/application unfreezing the filesystems before qemu-ga. This
situation *is* within qemu-ga's control, and should be reported as an
error. Same for the other failures below.

> +            fprintf(stderr, "failed to complete backup");
>          }
>          break;
> =

> @@ -480,18 +480,18 @@ void requester_thaw(int *num_vols, ErrorSet *errset)
> =

>      case VSS_E_UNEXPECTED_PROVIDER_ERROR:
>          if (WaitForSingleObject(vss_ctx.hEventTimeout, 0) !=3D WAIT_OBJE=
CT_0) {
> -            err_set(errset, hr, "unexpected error in VSS provider");
> +            fprintf(stderr, "unexpected error in VSS provider");
>              break;
>          }
>          /* fall through if hEventTimeout is signaled */
> =

>      case (HRESULT)VSS_E_HOLD_WRITES_TIMEOUT:
> -        err_set(errset, hr, "couldn't hold writes: "
> +        fprintf(stderr, "couldn't hold writes: "
>                  "fsfreeze is limited up to 10 seconds");
>          break;
> =

>      default:
> -        err_set(errset, hr, "failed to do snapshot set");
> +        fprintf(stderr, "failed to do snapshot set");
>      }
> =

>      if (err_is_set(errset)) {
> -- =

> 2.9.3
>=20
