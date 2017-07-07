Received: from eggs.gnu.org ([2001:4830:134:3::10]:42902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dTOf5-0007mF-Oi
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dTOf2-0005JK-Lh
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:30:51 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:52689)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dTOf2-0005IJ-EE
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:30:48 -0400
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-9-rth@twiddle.net>
	<9645bafa-2c7e-96e8-5f3c-9cf7a9415285@physik.fu-berlin.de>
	<51a3a21f-6145-d721-170f-b8cf20cbc2d9@twiddle.net>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <313d3f03-f487-4881-5f0a-6dd150f1ebdc@physik.fu-berlin.de>
Date: Fri, 7 Jul 2017 10:30:42 +0200
MIME-Version: 1.0
In-Reply-To: <51a3a21f-6145-d721-170f-b8cf20cbc2d9@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/27] linux-user/sh4: Notice gUSA
 regions during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 07/07/2017 10:20 AM, Richard Henderson wrote:
> How do I reproduce this from the filesystem image you linked earlier?

So, the problem happens in the tzdata package when it's being configured:

(sid-sh4-sbuild)root@nofan:/# dpkg-reconfigure tzdata
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:en",
        LC_ALL = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 76.)
debconf: falling back to frontend: Readline
Configuring tzdata
------------------

Please select the geographic area in which you live. Subsequent configuration questions will narrow this down by
presenting a list of cities, representing the time zones in which they are located.

  1. Africa   3. Antarctica  5. Arctic  7. Atlantic  9. Indian    11. SystemV  13. Etc
  2. America  4. Australia   6. Asia    8. Europe    10. Pacific  12. US
Geographic area: 8

Please select the city or region corresponding to your time zone.

  1. Amsterdam   10. Bucharest   19. Isle_of_Man  28. Luxembourg  37. Paris       46. Simferopol  55. Vaduz
  2. Andorra     11. Budapest    20. Istanbul     29. Madrid      38. Podgorica   47. Skopje      56. Vatican
  3. Astrakhan   12. Busingen    21. Jersey       30. Malta       39. Prague      48. Sofia       57. Vienna
  4. Athens      13. Chisinau    22. Kaliningrad  31. Mariehamn   40. Riga        49. Stockholm   58. Vilnius
  5. Belfast     14. Copenhagen  23. Kiev         32. Minsk       41. Rome        50. Tallinn     59. Volgograd
  6. Belgrade    15. Dublin      24. Kirov        33. Monaco      42. Samara      51. Tirane      60. Warsaw
  7. Berlin      16. Gibraltar   25. Lisbon       34. Moscow      43. San_Marino  52. Tiraspol    61. Zagreb
  8. Bratislava  17. Guernsey    26. Ljubljana    35. Nicosia     44. Sarajevo    53. Ulyanovsk   62. Zaporozhye
  9. Brussels    18. Helsinki    27. London       36. Oslo        45. Saratov     54. Uzhgorod    63. Zurich
Time zone: 7


Current default time zone: 'Europe/Berlin'
Local time is now:      Fri Jul  7 10:26:31 CEST 2017.
Universal Time is now:  Fri Jul  7 08:26:31 UTC 2017.

qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault
(sid-sh4-sbuild)root@nofan:/#

The scripts which are run here can be found as /var/lib/dpkg/info/tzdata.{config,postinst). I don't know
yet which command in particular triggers the crash.

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
