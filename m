Received: from eggs.gnu.org ([2001:4830:134:3::10]:32797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duW6e-0004e9-SG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duW6b-0000ey-Ql
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:55:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1duW6b-0000aw-Lf
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:55:21 -0400
Date: Wed, 20 Sep 2017 11:55:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170920035512.GF18491@lemon>
References: <20170919180038.26056-1-dgilbert@redhat.com>
	<20170919180038.26056-6-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170919180038.26056-6-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] migration: Route more error paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com, rth@twiddle.net

On Tue, 09/19 19:00, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> vmstate_save is called in a few places, and vmstate_save_state is
> called in lots of places.
> 
> Route error returns from the easier cases back up;  there are lots
> of more complex cases where there own error paths need fixing.

Did you mean s/there/their/ ?

<snip>

> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index e643ac662b..ab3e430c2c 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -70,7 +70,7 @@ static void save_vmstate(const VMStateDescription *desc, void *obj)
>      QEMUFile *f = open_test_file(true);
>  
>      /* Save file with vmstate */
> -    vmstate_save_state(f, desc, obj, NULL);
> +    g_assert(!vmstate_save_state(f, desc, obj, NULL));

Though this is test code, isn't putting anything with a side effect into an
assert expression a very bad pattern in general?

>      qemu_put_byte(f, QEMU_VM_EOF);
>      g_assert(!qemu_file_get_error(f));
>      qemu_fclose(f);
> @@ -381,7 +381,7 @@ static void test_save_noskip(void)
>      QEMUFile *fsave = open_test_file(true);
>      TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
>                         .skip_c_e = false };
> -    vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
> +    g_assert(!vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL));
>      g_assert(!qemu_file_get_error(fsave));
>  
>      uint8_t expected[] = {
> @@ -402,7 +402,7 @@ static void test_save_skip(void)
>      QEMUFile *fsave = open_test_file(true);
>      TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
>                         .skip_c_e = true };
> -    vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
> +    g_assert(!vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL));
>      g_assert(!qemu_file_get_error(fsave));
>  
>      uint8_t expected[] = {
> -- 
> 2.13.5
> 
> 

Fam
