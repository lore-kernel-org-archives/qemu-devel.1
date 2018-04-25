Received: from eggs.gnu.org ([2001:4830:134:3::10]:45014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBAx5-0007Gi-Bm
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBAx2-0001YC-60
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:18:39 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:38175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBAx1-0001Xl-VR
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:18:36 -0400
Received: by mail-qt0-x241.google.com with SMTP id z23-v6so25092632qti.5
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 20:18:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-46-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <09924422-8ed3-adca-b2a9-0a4214860972@amsat.org>
Date: Wed, 25 Apr 2018 00:18:28 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-46-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 45/46] tests/Makefile.include: add
 [build|clean|check]-tcg targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 12:24 PM, Alex Bennée wrote:
> This will ensure all linux-user targets build their guest test
> programs and ensure check-tcg will run the respective tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2
>   - use -include instead of complex macro stuff
>   - also include TARGET_BASE_ARCH/Makefile
> v3
>   - add build-tcg, make check-tcg actually run tests
> ---
>  tests/Makefile.include     | 26 ++++++++++++++++++++++-
>  tests/tcg/Makefile.include | 43 ++++++++++++++++++++++----------------
>  2 files changed, 50 insertions(+), 19 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3d2f0458ab..310ccefdd9 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -10,6 +10,7 @@ check-help:
>  	@echo " $(MAKE) check-speed          Run qobject speed tests"
>  	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
>  	@echo " $(MAKE) check-block          Run block tests"
> +	@echo " $(MAKE) check-tcg            Run TCG tests"
>  	@echo " $(MAKE) check-report.html    Generates an HTML test report"
>  	@echo " $(MAKE) check-clean          Clean the tests"
>  	@echo
> @@ -916,6 +917,30 @@ check-report.xml: $(patsubst %,check-report-qtest-%.xml, $(QTEST_TARGETS)) check
>  check-report.html: check-report.xml
>  	$(call quiet-command,gtester-report $< > $@,"GEN","$@")
>  
> +# Per guest TCG tests
> +
> +LINUX_USER_TARGETS=$(filter %-linux-user,$(TARGET_LIST))
> +BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(LINUX_USER_TARGETS))
> +CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(LINUX_USER_TARGETS))
> +RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(LINUX_USER_TARGETS))
> +
> +build-tcg-tests-%:
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" guest-tests,)
> +
> +run-tcg-tests-%: build-tcg-tests-%
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" run-guest-tests,)
> +
> +clean-tcg-tests-%:
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" clean-guest-tests,)
> +
> +.PHONY: build-tcg
> +build-tcg: $(BUILD_TCG_TARGET_RULES)
> +
> +.PHONY: check-tcg
> +check-tcg: $(RUN_TCG_TARGET_RULES)
> +
> +.PHONY: clean-tcg
> +clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>  
>  # Other tests
>  
> @@ -958,7 +983,6 @@ check-speed: $(patsubst %,check-%, $(check-speed-y))
>  check-block: $(patsubst %,check-%, $(check-block-y))
>  check: check-qapi-schema check-unit check-qtest check-decodetree
>  check-clean:
> -	$(MAKE) -C tests/tcg clean
>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
>  	rm -f tests/test-qapi-gen-timestamp
> diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
> index cb8bb36026..67e89ecb67 100644
> --- a/tests/tcg/Makefile.include
> +++ b/tests/tcg/Makefile.include
> @@ -8,19 +8,14 @@
>  # guest compiler or calling one of our docker images to do it for us.
>  #
>  
> -# The per ARCH makefile, if it exists holds extra information about
> -# useful docker images or alternative compiler flags. Include it if it
> -# exists
> +# The per ARCH makefile, if it exists, holds extra information about
> +# useful docker images or alternative compiler flags.
>  
> -ARCH_MAKEFILE=$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
> -CHECK_INCLUDE=$(wildcard $(ARCH_MAKEFILE))
> -
> -ifeq ($(ARCH_MAKEFILE),$(CHECK_INCLUDE))
> -include $(ARCH_MAKEFILE)
> -endif
> +-include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
> +-include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
>  
>  GUEST_BUILD=
> -
> +TCG_MAKE=$(SRC_PATH)/tests/tcg/Makefile
>  # Support installed Cross Compilers
>  
>  ifdef CROSS_CC_GUEST
> @@ -28,10 +23,10 @@ ifdef CROSS_CC_GUEST
>  .PHONY: cross-build-guest-tests
>  cross-build-guest-tests:
>  	$(call quiet-command, \
> -          (mkdir -p tests && cd tests && \
> -	   make -f $(SRC_PATH)/tests/tcg/Makefile ARCH=$(TARGET_NAME) CC=$(CROSS_CC_GUEST)), \
> -	  "CROSS-BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
> -
> +	   (mkdir -p tests && cd tests && \
> +	    make -f $(TCG_MAKE) CC=$(CROSS_CC_GUEST) \
> +				EXTRA_CFLAGS=$(CROSS_CC_GUEST_CFLAGS)), \
> +	"CROSS-BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
>  
>  GUEST_BUILD=cross-build-guest-tests
>  
> @@ -54,9 +49,10 @@ DOCKER_PREREQ=docker-image-$(DOCKER_IMAGE)
>  .PHONY: docker-build-guest-tests
>  docker-build-guest-tests: $(DOCKER_PREREQ)
>  	$(call quiet-command, \
> -          (mkdir -p tests && cd tests && \
> -	   make -f $(SRC_PATH)/tests/tcg/Makefile ARCH=$(TARGET_NAME) CC=$(DOCKER_COMPILE_CMD)), \
> -	  "CROSS-BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
> +	  (mkdir -p tests && cd tests && \
> +	   make -f $(TCG_MAKE) CC=$(DOCKER_COMPILE_CMD) \
> +			       EXTRA_CFLAGS=$(DOCKER_CROSS_COMPILER_CFLAGS)), \
> +	"CROSS-BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
>  
>  GUEST_BUILD=docker-build-guest-tests
>  
> @@ -68,9 +64,20 @@ endif
>  
>  ifneq ($(GUEST_BUILD),)
>  guest-tests: $(GUEST_BUILD)
> +
> +run-guest-tests: guest-tests
> +	$(call quiet-command, \
> +	(cd tests && make -f $(TCG_MAKE) run), \
> +	"RUN-TESTS", "for $(TARGET_NAME)")
> +
>  else
>  guest-tests:
> -	$(call quiet-command, /bin/true, "CROSS-BUILD", "$(TARGET_NAME) guest-tests SKIPPED")
> +	$(call quiet-command, /bin/true, "CROSS-BUILD", \
> +		"$(TARGET_NAME) guest-tests SKIPPED")
> +
> +run-guest-tests:
> +	$(call quiet-command, /bin/true, "RUN-TESTS", \
> +		"for $(TARGET_NAME) SKIPPED")
>  endif
>  
>  # It doesn't mater if these don't exits

I forgot I switched to this default:

$ alias make
alias make='make -j$(nproc) -l$(bc<<<"scale=2;$(nproc)*.94")'

with which this script is very unhappy :)

$ make -j4 check-tcg
  BUILD   debian9
  BUILD   debian-sid
  BUILD   debian9
  BUILD   debian9
^CTraceback (most recent call last):
  File "/source/qemu/tests/docker/docker.py", line 456, in <module>
    sys.exit(main())
  File "/source/qemu/tests/docker/docker.py", line 453, in main
    return args.cmdobj.run(args, argv)
  File "/source/qemu/tests/docker/docker.py", line 326, in run
Traceback (most recent call last):
  File "/source/qemu/tests/docker/docker.py", line 456, in <module>
    extra_files_cksum=cksum)
  File "/source/qemu/tests/docker/docker.py", line 209, in build_image
    sys.exit(main())
  File "/source/qemu/tests/docker/docker.py", line 453, in main
Traceback (most recent call last):
  File "/source/qemu/tests/docker/docker.py", line 456, in <module>
    return args.cmdobj.run(args, argv)
  File "/source/qemu/tests/docker/docker.py", line 326, in run
Traceback (most recent call last):
    sys.exit(main())
  File "/source/qemu/tests/docker/docker.py", line 456, in <module>
    sys.exit(main())
  File "/source/qemu/tests/docker/docker.py", line 453, in main
    return args.cmdobj.run(args, argv)
  File "/source/qemu/tests/docker/docker.py", line 326, in run
    extra_files_cksum=cksum)
  File "/source/qemu/tests/docker/docker.py", line 209, in build_image
    quiet=quiet)
  File "/source/qemu/tests/docker/docker.py", line 147, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 185, in check_call
        extra_files_cksum=cksum)
  File "/source/qemu/tests/docker/docker.py", line 209, in build_image
    quiet=quiet)
  File "/source/qemu/tests/docker/docker.py", line 147, in _do_check
quiet=quiet)
      File "/source/qemu/tests/docker/docker.py", line 147, in _do_check
    retcode = call(*popenargs, **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 172, in call
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 185, in check_call
    return Popen(*popenargs, **kwargs).wait()
  File "/usr/lib/python2.7/subprocess.py", line 1099, in wait
      File "/source/qemu/tests/docker/docker.py", line 453, in main
retcode = call(*popenargs, **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 172, in call
    return args.cmdobj.run(args, argv)
  File "/source/qemu/tests/docker/docker.py", line 326, in run
    extra_files_cksum=cksum)
  File "/source/qemu/tests/docker/docker.py", line 209, in build_image
        quiet=quiet)
  File "/source/qemu/tests/docker/docker.py", line 147, in _do_check
return Popen(*popenargs, **kwargs).wait()
        return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 185, in check_call
  File "/usr/lib/python2.7/subprocess.py", line 1099, in wait
    retcode = call(*popenargs, **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 172, in call
pid, sts = _eintr_retry_call(os.waitpid, self.pid, 0)
  File "/usr/lib/python2.7/subprocess.py", line 125, in _eintr_retry_call
    return func(*args)
KeyboardInterrupt
    pid, sts = _eintr_retry_call(os.waitpid, self.pid, 0)
  File "/usr/lib/python2.7/subprocess.py", line 125, in _eintr_retry_call
    return func(*args)
KeyboardInterrupt
return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 185, in check_call
        return Popen(*popenargs, **kwargs).wait()
  File "/usr/lib/python2.7/subprocess.py", line 1099, in wait
    retcode = call(*popenargs, **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 172, in call
    return Popen(*popenargs, **kwargs).wait()
  File "/usr/lib/python2.7/subprocess.py", line 1099, in wait
    pid, sts = _eintr_retry_call(os.waitpid, self.pid, 0)
  File "/usr/lib/python2.7/subprocess.py", line 125, in _eintr_retry_call
    return func(*args)
KeyboardInterruptpid, sts = _eintr_retry_call(os.waitpid, self.pid, 0)

  File "/usr/lib/python2.7/subprocess.py", line 125, in _eintr_retry_call
    return func(*args)
KeyboardInterrupt
^[[AError in atexit._run_exitfuncs:
Traceback (most recent call last):
  File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
    func(*targs, **kargs)
  File "/source/qemu/tests/docker/docker.py", line 174, in _kill_instances
    return self._do_kill_instances(True)
  File "/source/qemu/tests/docker/docker.py", line 154, in
_do_kill_instances
    resp = self._output(["inspect", i])
  File "/source/qemu/tests/docker/docker.py", line 179, in _output
    **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 223, in check_output
    raise CalledProcessError(retcode, cmd, output=output)
CalledProcessError: Command '['docker', 'inspect', '9fc7dac8cd07']'
returned non-zero exit status 1
Error in sys.exitfunc:
Traceback (most recent call last):
  File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
    func(*targs, **kargs)
  File "/source/qemu/tests/docker/docker.py", line 174, in _kill_instances
    return self._do_kill_instances(True)
  File "/source/qemu/tests/docker/docker.py", line 154, in
_do_kill_instances
    resp = self._output(["inspect", i])
  File "/source/qemu/tests/docker/docker.py", line 179, in _output
    **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 223, in check_output
    raise CalledProcessError(retcode, cmd, output=output)
subprocess.CalledProcessError: Command '['docker', 'inspect',
'9fc7dac8cd07']' returned non-zero exit status 1
Error in atexit._run_exitfuncs:
Traceback (most recent call last):
  File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
    func(*targs, **kargs)
  File "/source/qemu/tests/docker/docker.py", line 174, in _kill_instances
    return self._do_kill_instances(True)
  File "/source/qemu/tests/docker/docker.py", line 154, in
_do_kill_instances
    resp = self._output(["inspect", i])
  File "/source/qemu/tests/docker/docker.py", line 179, in _output
    **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 223, in check_output
    raise CalledProcessError(retcode, cmd, output=output)
CalledProcessError: Command '['docker', 'inspect', '9fc7dac8cd07']'
returned non-zero exit status 1
Error in sys.exitfunc:
Traceback (most recent call last):
  File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
    func(*targs, **kargs)
  File "/source/qemu/tests/docker/docker.py", line 174, in _kill_instances
    return self._do_kill_instances(True)
  File "/source/qemu/tests/docker/docker.py", line 154, in
_do_kill_instances
    resp = self._output(["inspect", i])
  File "/source/qemu/tests/docker/docker.py", line 179, in _output
    **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 223, in check_output
    raise CalledProcessError(retcode, cmd, output=output)
subprocess.CalledProcessError: Command '['docker', 'inspect',
'9fc7dac8cd07']' returned non-zero exit status 1
Error in atexit._run_exitfuncs:
Traceback (most recent call last):
  File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
    func(*targs, **kargs)
  File "/source/qemu/tests/docker/docker.py", line 174, in _kill_instances
    return self._do_kill_instances(True)
  File "/source/qemu/tests/docker/docker.py", line 154, in
_do_kill_instances
    resp = self._output(["inspect", i])
  File "/source/qemu/tests/docker/docker.py", line 179, in _output
    **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 223, in check_output
    raise CalledProcessError(retcode, cmd, output=output)
make[1]: *** [/source/qemu/tests/docker/Makefile.include:39:
docker-image-debian9] Interrupt
CalledProcessError: Command '['docker', 'inspect', '9fc7dac8cd07']'
returned non-zero exit status 1
Error in sys.exitfunc:
Traceback (most recent call last):
  File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
    func(*targs, **kargs)
  File "/source/qemu/tests/docker/docker.py", line 174, in _kill_instances
    return self._do_kill_instances(True)
  File "/source/qemu/tests/docker/docker.py", line 154, in
_do_kill_instances
    resp = self._output(["inspect", i])
  File "/source/qemu/tests/docker/docker.py", line 179, in _output
    **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 223, in check_output
    raise CalledProcessError(retcode, cmd, output=output)
subprocess.CalledProcessError: Command '['docker', 'inspect',
'9fc7dac8cd07']' returned non-zero exit status 1
make: *** [/source/qemu/tests/Makefile.include:928:
build-tcg-tests-aarch64_be-linux-user] Interrupt
make[1]: *** [/source/qemu/tests/docker/Makefile.include:39:
docker-image-debian9] Interrupt
make: *** [/source/qemu/tests/Makefile.include:928:
build-tcg-tests-aarch64-linux-user] Interrupt
make[1]: *** [/source/qemu/tests/docker/Makefile.include:39:
docker-image-debian9] Interrupt
make: *** [/source/qemu/tests/Makefile.include:928:
build-tcg-tests-arm-linux-user] Interrupt
Error in atexit._run_exitfuncs:
Traceback (most recent call last):
  File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
    func(*targs, **kargs)
  File "/source/qemu/tests/docker/docker.py", line 174, in _kill_instances
    return self._do_kill_instances(True)
  File "/source/qemu/tests/docker/docker.py", line 154, in
_do_kill_instances
    resp = self._output(["inspect", i])
  File "/source/qemu/tests/docker/docker.py", line 179, in _output
    **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 223, in check_output
    raise CalledProcessError(retcode, cmd, output=output)
CalledProcessError: Command '['docker', 'inspect', '9fc7dac8cd07']'
returned non-zero exit status 1
Error in sys.exitfunc:
Traceback (most recent call last):
  File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
    func(*targs, **kargs)
  File "/source/qemu/tests/docker/docker.py", line 174, in _kill_instances
    return self._do_kill_instances(True)
  File "/source/qemu/tests/docker/docker.py", line 154, in
_do_kill_instances
    resp = self._output(["inspect", i])
  File "/source/qemu/tests/docker/docker.py", line 179, in _output
    **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 223, in check_output
    raise CalledProcessError(retcode, cmd, output=output)
subprocess.CalledProcessError: Command '['docker', 'inspect',
'9fc7dac8cd07']' returned non-zero exit status 1
make[1]: *** [/source/qemu/tests/docker/Makefile.include:39:
docker-image-debian-sid] Interrupt
make: *** [/source/qemu/tests/Makefile.include:928:
build-tcg-tests-alpha-linux-user] Interrupt
