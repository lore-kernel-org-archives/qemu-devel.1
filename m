Received: from eggs.gnu.org ([2001:4830:134:3::10]:47114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cvm0d-0004ru-4X
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cvm0Z-0007Cu-Vp
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:34:07 -0400
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:34228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cvm0Z-0007Ck-Oq
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:34:03 -0400
Received: by mail-ua0-x22d.google.com with SMTP id 9so9175766uau.1
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 07:34:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149134654744.1924.4586865323465702075@loki>
References: <20170321141435.23701-1-sameeh@daynix.com>
	<149134654744.1924.4586865323465702075@loki>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed, 5 Apr 2017 17:34:02 +0300
Message-ID: <CAKPgXcFDqHXdJfrvGsx4r5FQo=x0FX8C9vbe5NyCyG=CQF4KdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>

On Wed, Apr 5, 2017 at 1:55 AM, Michael Roth <mdroth@linux.vnet.ibm.com>
wrote:

> Quoting Sameeh Jubran (2017-03-21 09:14:35)
> > Errors that are related to ur inner implementation for the thaw command
> > shouldn't be displayed to the user.
> >
> > Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
> > ---
> >  qga/vss-win32/requester.cpp | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> > index 0cd2f0e..272e71b 100644
> > --- a/qga/vss-win32/requester.cpp
> > +++ b/qga/vss-win32/requester.cpp
> > @@ -463,7 +463,7 @@ void requester_thaw(int *num_vols, ErrorSet *errset)
> >              hr = WaitForAsync(pAsync);
> >          }
> >          if (FAILED(hr)) {
> > -            err_set(errset, hr, "failed to complete backup");
>
> We cannot do this. If the freeze operation didn't successfully maintain
> the frozen state for entire duration we *must* report an error to the
> user, otherwise users have no way to know that their snapshot might be
> completely corrupted. Well, I suppose they can look at
> guest-fsfreeze-thaw's return value and check that it matches the number
> of volumes that were originally frozen, but that aspect is intended as a
> sanity check to identify situations outside of qemu-ga's control, like
> another user/application unfreezing the filesystems before qemu-ga. This
> situation *is* within qemu-ga's control, and should be reported as an
> error. Same for the other failures below.

This patch was introduced to hide the error "{"error": {"class":
"GenericError", "desc": "couldn't hold writes: fsfreeze is limited up to 10
seconds: "}" which shows up whenever we
execute thaw after 10 seconds have passed from freeze event and in order to
align the behaviour Windows with Linux. However I agree with you about
informing the user about possible
corruption during the backup operation.

>


> > +            fprintf(stderr, "failed to complete backup");
> >          }
> >          break;
> >
> > @@ -480,18 +480,18 @@ void requester_thaw(int *num_vols, ErrorSet
> *errset)
> >
> >      case VSS_E_UNEXPECTED_PROVIDER_ERROR:
> >          if (WaitForSingleObject(vss_ctx.hEventTimeout, 0) !=
> WAIT_OBJECT_0) {
> > -            err_set(errset, hr, "unexpected error in VSS provider");
> > +            fprintf(stderr, "unexpected error in VSS provider");
> >              break;
> >          }
> >          /* fall through if hEventTimeout is signaled */
> >
> >      case (HRESULT)VSS_E_HOLD_WRITES_TIMEOUT:
> > -        err_set(errset, hr, "couldn't hold writes: "
> > +        fprintf(stderr, "couldn't hold writes: "
> >                  "fsfreeze is limited up to 10 seconds");
> >          break;
> >
> >      default:
> > -        err_set(errset, hr, "failed to do snapshot set");
> > +        fprintf(stderr, "failed to do snapshot set");
> >      }
> >
> >      if (err_is_set(errset)) {
> > --
> > 2.9.3
> >
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
