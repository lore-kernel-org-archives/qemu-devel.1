Received: from eggs.gnu.org ([2001:4830:134:3::10]:42932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTYkb-0000IL-VE
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTYkY-0001Uv-Ux
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:44:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:45733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTYkY-0001U9-Pw
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:44:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTYkX-00070V-DT
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:44:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 508562E80CB
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:44:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 18:33:14 -0000
From: Thomas Huth <1357206@bugs.launchpad.net>
Reply-To: Bug 1357206 <1357206@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140815062532.23413.69773.malonedeb@wampee.canonical.com>
Message-Id: <20170117183315.21058.47825.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1357206] Re: QEMU user mode still crashes in
 multi-thread code.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1357206

Title:
  QEMU user mode still crashes in multi-thread code.

Status in QEMU:
  Fix Released

Bug description:
  I compiled the qemu 2.0 release source and find out qemu crashing when
  emulating multi-thread code in user mode.

  I did a little search and found LP:668799 but it is far from now and
  it is probably not the problem here.

  I used program below as the test program:

  #include <stdio.h>
  #include <stdlib.h>
  #include <pthread.h>

  void *print_message_function( void *ptr );

  main()
  {
       pthread_t thread1, thread2;
       const char *message1 =3D "Thread 1";
       const char *message2 =3D "Thread 2";
       int  iret1, iret2;

      /* Create independent threads each of which will execute function
  */

       iret1 =3D pthread_create( &thread1, NULL, print_message_function, (v=
oid*) message1);
       if(iret1)
       {
           fprintf(stderr,"Error - pthread_create() return code: %d\n",iret=
1);
           exit(EXIT_FAILURE);
       }

       iret2 =3D pthread_create( &thread2, NULL, print_message_function, (v=
oid*) message2);
       if(iret2)
       {
           fprintf(stderr,"Error - pthread_create() return code: %d\n",iret=
2);
           exit(EXIT_FAILURE);
       }

       printf("pthread_create() for thread 1 returns: %d\n",iret1);
       printf("pthread_create() for thread 2 returns: %d\n",iret2);

       /* Wait till threads are complete before main continues. Unless we  =
*/
       /* wait we run the risk of executing an exit which will terminate   =
*/
       /* the process and all threads before the threads have completed.   =
*/

       pthread_join( thread1, NULL);
       pthread_join( thread2, NULL); =


       exit(EXIT_SUCCESS);
  }

  void *print_message_function( void *ptr )
  {
       char *message;
       message =3D (char *) ptr;
       printf("%s \n", message);
  }

  Compiled to i386 and aarch64 object, =

  and both qemu-i386 and qemu-aarch64 had segmentation faults.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1357206/+subscriptions
