Received: from eggs.gnu.org ([2001:4830:134:3::10]:39536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fT6KM-0005Cj-Nj
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fT6KH-0002Gs-VQ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:00:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180613123458.24685-1-kwolf@redhat.com>
	<20180613123458.24685-2-kwolf@redhat.com>
Date: Wed, 13 Jun 2018 16:00:27 +0200
In-Reply-To: <20180613123458.24685-2-kwolf@redhat.com> (Kevin Wolf's message
	of "Wed, 13 Jun 2018 14:34:56 +0200")
Message-ID: <87y3fiiy6c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/3] block: Remove deprecated -drive
 geometry options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> The -drive options cyls, heads, secs and trans were deprecated in
> QEMU 2.10. It's time to remove them.
>
> hd-geo-test tested both the old version with geometry options in -drive
> and the new one with -device. Therefore the code using -drive doesn't
> have to be replaced there, we just need to remove the -drive test cases.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
[...]
> diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
> index 24870b38f4..d263a74ec0 100644
> --- a/tests/hd-geo-test.c
> +++ b/tests/hd-geo-test.c
> @@ -347,22 +347,6 @@ static void test_ide_drive_user(const char *dev, bool trans)
  static void test_ide_drive_user(const char *dev, bool trans)
  {
      char **argv = g_new0(char *, ARGV_SIZE);
      char *args, *opts;
      int argc;
      int secs = img_secs[backend_small];
      const CHST expected_chst = { secs / (4 * 32) , 4, 32, trans };

      argc = setup_common(argv, ARGV_SIZE);
      opts = g_strdup_printf("%s,%s%scyls=%d,heads=%d,secs=%d",
                             dev ?: "",
                             trans && dev ? "bios-chs-" : "",
                             trans ? "trans=lba," : "",
                             expected_chst.cyls, expected_chst.heads,
                             expected_chst.secs);
      cur_ide[0] = &expected_chst;
      argc = setup_ide(argc, argv, ARGV_SIZE,
                       0, dev ? opts : NULL, backend_small, mbr_chs,
                       dev ? "" : opts);
      g_free(opts);
      args = g_strjoinv(" ", argv);
      qtest_start(args);
      g_strfreev(argv);
      g_free(args);
      test_cmos();
      qtest_end();
>  }
>  
>  /*
> - * Test case: IDE device (if=ide) with explicit CHS
> - */
> -static void test_ide_drive_user_chs(void)
> -{
> -    test_ide_drive_user(NULL, false);
> -}
> -
> -/*
> - * Test case: IDE device (if=ide) with explicit CHS and translation
> - */
> -static void test_ide_drive_user_chst(void)
> -{
> -    test_ide_drive_user(NULL, true);
> -}

All remaining calls of test_ide_drive_user() pass non-null @dev.  Please
simplify test_ide_drive_user() accordingly.

> -
> -/*
>   * Test case: IDE device (if=none) with explicit CHS
>   */
>  static void test_ide_device_user_chs(void)
> @@ -422,8 +406,6 @@ int main(int argc, char **argv)
>      qtest_add_func("hd-geo/ide/drive/mbr/blank", test_ide_drive_mbr_blank);
>      qtest_add_func("hd-geo/ide/drive/mbr/lba", test_ide_drive_mbr_lba);
>      qtest_add_func("hd-geo/ide/drive/mbr/chs", test_ide_drive_mbr_chs);
> -    qtest_add_func("hd-geo/ide/drive/user/chs", test_ide_drive_user_chs);
> -    qtest_add_func("hd-geo/ide/drive/user/chst", test_ide_drive_user_chst);
>      qtest_add_func("hd-geo/ide/drive/cd_0", test_ide_drive_cd_0);
>      qtest_add_func("hd-geo/ide/device/mbr/blank", test_ide_device_mbr_blank);
>      qtest_add_func("hd-geo/ide/device/mbr/lba", test_ide_device_mbr_lba);
[...]

With that done:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
