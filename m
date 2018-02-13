Received: from eggs.gnu.org ([2001:4830:134:3::10]:50148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1elcYL-0002Yh-QO
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1elcYH-00060B-JM
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:31:29 -0500
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234]:38438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1elcYH-0005zW-CW
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:31:25 -0500
Received: by mail-io0-x234.google.com with SMTP id d13so21681413iog.5
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:31:25 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180128221510.13722-1-richard.henderson@linaro.org>
	<CAFEAcA_3s_prsUy7CXP3rC-i048FeEduqe92Mwg_VrTJ7YScHg@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <18af5519-95cd-f00e-1915-75183e94eb38@twiddle.net>
Date: Tue, 13 Feb 2018 07:31:21 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_3s_prsUy7CXP3rC-i048FeEduqe92Mwg_VrTJ7YScHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Use *at functions to implement
 interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>

On 02/13/2018 04:12 AM, Peter Maydell wrote:
>> +const char *linux_user_path(const char *pathname)
>> +{
>> +    static THREAD size_t save_len;
>> +    static THREAD char *save_buf;
> 
> I think THREAD is a remnant of when we used to support configuration
> with and without NPTL, so we should be looking to get rid of it,
> and just use __thread instead.

Fair.

>> +    size_t len, prefix_len, path_len;
>> +    int e;
>> +
>> +    /* Only consider absolute paths.  */
>> +    if (pathname[0] != '/' || interp_dirfd < 0) {
>> +        return pathname;
>> +    }
>> +
>> +    /* Test if the path within interp_dir exists.  */
>> +    e = faccessat(interp_dirfd, pathname + 1, F_OK, AT_SYMLINK_NOFOLLOW);
>> +    if (e < 0 && errno != ENOENT) {
>> +        return pathname;
>> +    }
>> +
>> +    /* It does -- form the new absolute path.  */
>> +    prefix_len = strlen(interp_prefix);
>> +    path_len = strlen(pathname) + 1;
>> +    len = prefix_len + path_len;
>> +    if (len <= save_len) {
>> +        save_len = len;
>> +        save_buf = realloc(save_buf, len);
>> +    }
>> +    memcpy(save_buf, interp_prefix, prefix_len);
>> +    memcpy(save_buf + prefix_len, pathname, path_len);
>> +
>> +    return save_buf;
>> +}
> 
> The split of an atomic syscall into a two-part thing involving
> an existence/access check and then the syscall makes me a bit
> nervous about races, but I guess there's nothing terrible that
> would happen here...

It's no different from what we have now except that currently the existence
check is done *much* earlier.

> I had a look at where we still need this function:
>  * NR_acct
>  * NR_statfs (various flavours)
>  * NR_inotify_add_watch
> 
> For inotify_add_watch, we can first try the syscall on the
> path inside the interp_dir, and if that fails ENOENT then
> try it with the normal path.

Fair.

>>      /* Scan interp_prefix dir for replacement files. */
>> -    init_paths(interp_prefix);
>> +    interp_dirfd = open(interp_prefix, O_CLOEXEC | O_DIRECTORY | O_PATH);
>>
>>      init_qemu_uname_release();
> 
> I wonder if there are guest programs that make assumptions about
> file descriptor numbers such that it would be worthwhile dup2'ing
> the interp_dirfd away from the presumably low number fd it will
> get by default into something larger...

Hmm.  Using dup2(probe, probe) to test if the new (high) fd itself has not been
allocated?

> Have you tried an LTP test run with this patchset to see whether
> we get any new passes/fails ?

No.  All I've really done is point -L at a debian rootfs and see that mainline
qemu is unusable in that state.


r~
