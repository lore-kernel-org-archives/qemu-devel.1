Received: from eggs.gnu.org ([2001:4830:134:3::10]:38768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gDSkR-0005xE-Ay
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gDSkJ-0000Mu-0S
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:15:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gDSkI-0000LP-Ni
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:15:10 -0400
References: <1539946806-695-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <4837dc8a-c4a7-9bd8-649a-3b35b0fe20fa@redhat.com>
Date: Fri, 19 Oct 2018 13:14:57 +0200
MIME-Version: 1.0
In-Reply-To: <1539946806-695-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/migration-test: Disable s390x test
 when running with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Peter Maydell <peter.maydell@linaro.org>, Wei Huang <wei@redhat.com>, david@redhat.com, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 19/10/2018 13:00, Thomas Huth wrote:
> The migration test for s390x sometimes hangs when running with TCG,
> similar to the problems that we have already observed with TCG for
> the ppc64 guests. Thus disable the s390x test when we are not running
> with KVM for now until the problem with TCG has been resolved.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/migration-test.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index b792025..06ca506 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -803,6 +803,22 @@ int main(int argc, char **argv)
>          return 0;
>      }
>  
> +    /*
> +     * Similar to ppc64, s390x seems to be touchy with TCG, so disable it
> +     * there until the problems are resolved
> +     */
> +    if (g_str_equal(qtest_get_arch(), "s390x")) {
> +#if defined(HOST_S390X)
> +        if (access("/dev/kvm", R_OK | W_OK)) {
> +            g_test_message("Skipping test: kvm not available");
> +            return 0;
> +        }
> +#else
> +        g_test_message("Skipping test: Need s390x host to work properly");
> +        return 0;
> +#endif
> +    }
> +
>      tmpfs = mkdtemp(template);
>      if (!tmpfs) {
>          g_test_message("mkdtemp on path (%s): %s\n", template, strerror(errno));
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
