Received: from eggs.gnu.org ([2001:4830:134:3::10]:42308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fengguang.wu@intel.com>) id 1dvMPK-00082p-2c
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fengguang.wu@intel.com>) id 1dvMPG-0001rd-R2
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:46:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:42412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fengguang.wu@intel.com>)
	id 1dvMPG-0001qo-6n
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:46:06 -0400
Date: Fri, 22 Sep 2017 19:45:38 +0800
From: kbuild test robot <lkp@intel.com>
Message-ID: <201709221958.BnbMI5ZN%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170919115814.14724-2-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] fw_cfg: add DMA register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, somlo@cmu.edu, qemu-devel@nongnu.org, mst@redhat.com


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Marc-André,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.14-rc1 next-20170922]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/marcandre-lureau-redhat-com/fw_cfg-add-DMA-operations-etc-vmcoreinfo-support/20170922-182716
config: i386-randconfig-x075-201738 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/list.h:4,
                    from include/linux/module.h:9,
                    from drivers//firmware/qemu_fw_cfg.c:30:
   drivers//firmware/qemu_fw_cfg.c: In function 'fw_cfg_cmdline_set':
   drivers//firmware/qemu_fw_cfg.c:690:43: error: 'process' undeclared (first use in this function)
         (processed != 1 && processed != 3 && process != 4))
                                              ^
   include/linux/compiler.h:156:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers//firmware/qemu_fw_cfg.c:689:2: note: in expansion of macro 'if'
     if (str[consumed] ||
     ^~
   drivers//firmware/qemu_fw_cfg.c:690:43: note: each undeclared identifier is reported only once for each function it appears in
         (processed != 1 && processed != 3 && process != 4))
                                              ^
   include/linux/compiler.h:156:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers//firmware/qemu_fw_cfg.c:689:2: note: in expansion of macro 'if'
     if (str[consumed] ||
     ^~

vim +/if +689 drivers//firmware/qemu_fw_cfg.c

75f3e8e4 Gabriel Somlo     2016-01-28  639  
75f3e8e4 Gabriel Somlo     2016-01-28  640  /* use special scanf/printf modifier for phys_addr_t, resource_size_t */
75f3e8e4 Gabriel Somlo     2016-01-28  641  #define PH_ADDR_SCAN_FMT "@%" __PHYS_ADDR_PREFIX "i%n" \
75f3e8e4 Gabriel Somlo     2016-01-28  642  			 ":%" __PHYS_ADDR_PREFIX "i" \
46ebd6f8 Marc-André Lureau 2017-09-19  643  			 ":%" __PHYS_ADDR_PREFIX "i%n" \
75f3e8e4 Gabriel Somlo     2016-01-28  644  			 ":%" __PHYS_ADDR_PREFIX "i%n"
75f3e8e4 Gabriel Somlo     2016-01-28  645  
75f3e8e4 Gabriel Somlo     2016-01-28  646  #define PH_ADDR_PR_1_FMT "0x%" __PHYS_ADDR_PREFIX "x@" \
75f3e8e4 Gabriel Somlo     2016-01-28  647  			 "0x%" __PHYS_ADDR_PREFIX "x"
75f3e8e4 Gabriel Somlo     2016-01-28  648  
75f3e8e4 Gabriel Somlo     2016-01-28  649  #define PH_ADDR_PR_3_FMT PH_ADDR_PR_1_FMT \
75f3e8e4 Gabriel Somlo     2016-01-28  650  			 ":%" __PHYS_ADDR_PREFIX "u" \
75f3e8e4 Gabriel Somlo     2016-01-28  651  			 ":%" __PHYS_ADDR_PREFIX "u"
75f3e8e4 Gabriel Somlo     2016-01-28  652  
46ebd6f8 Marc-André Lureau 2017-09-19  653  #define PH_ADDR_PR_4_FMT PH_ADDR_PR_3_FMT \
46ebd6f8 Marc-André Lureau 2017-09-19  654  			 ":%" __PHYS_ADDR_PREFIX "u"
46ebd6f8 Marc-André Lureau 2017-09-19  655  
75f3e8e4 Gabriel Somlo     2016-01-28  656  static int fw_cfg_cmdline_set(const char *arg, const struct kernel_param *kp)
75f3e8e4 Gabriel Somlo     2016-01-28  657  {
46ebd6f8 Marc-André Lureau 2017-09-19  658  	struct resource res[4] = {};
75f3e8e4 Gabriel Somlo     2016-01-28  659  	char *str;
75f3e8e4 Gabriel Somlo     2016-01-28  660  	phys_addr_t base;
46ebd6f8 Marc-André Lureau 2017-09-19  661  	resource_size_t size, ctrl_off, data_off, dma_off;
75f3e8e4 Gabriel Somlo     2016-01-28  662  	int processed, consumed = 0;
75f3e8e4 Gabriel Somlo     2016-01-28  663  
75f3e8e4 Gabriel Somlo     2016-01-28  664  	/* only one fw_cfg device can exist system-wide, so if one
75f3e8e4 Gabriel Somlo     2016-01-28  665  	 * was processed on the command line already, we might as
75f3e8e4 Gabriel Somlo     2016-01-28  666  	 * well stop here.
75f3e8e4 Gabriel Somlo     2016-01-28  667  	 */
75f3e8e4 Gabriel Somlo     2016-01-28  668  	if (fw_cfg_cmdline_dev) {
75f3e8e4 Gabriel Somlo     2016-01-28  669  		/* avoid leaking previously registered device */
75f3e8e4 Gabriel Somlo     2016-01-28  670  		platform_device_unregister(fw_cfg_cmdline_dev);
75f3e8e4 Gabriel Somlo     2016-01-28  671  		return -EINVAL;
75f3e8e4 Gabriel Somlo     2016-01-28  672  	}
75f3e8e4 Gabriel Somlo     2016-01-28  673  
75f3e8e4 Gabriel Somlo     2016-01-28  674  	/* consume "<size>" portion of command line argument */
75f3e8e4 Gabriel Somlo     2016-01-28  675  	size = memparse(arg, &str);
75f3e8e4 Gabriel Somlo     2016-01-28  676  
46ebd6f8 Marc-André Lureau 2017-09-19  677  	/* get "@<base>[:<ctrl_off>:<data_off>[:<dma_off>]]" chunks */
75f3e8e4 Gabriel Somlo     2016-01-28  678  	processed = sscanf(str, PH_ADDR_SCAN_FMT,
75f3e8e4 Gabriel Somlo     2016-01-28  679  			   &base, &consumed,
46ebd6f8 Marc-André Lureau 2017-09-19  680  			   &ctrl_off, &data_off, &consumed,
46ebd6f8 Marc-André Lureau 2017-09-19  681  			   &dma_off, &consumed);
75f3e8e4 Gabriel Somlo     2016-01-28  682  
46ebd6f8 Marc-André Lureau 2017-09-19  683  	/* sscanf() must process precisely 1, 3 or 4 chunks:
75f3e8e4 Gabriel Somlo     2016-01-28  684  	 * <base> is mandatory, optionally followed by <ctrl_off>
46ebd6f8 Marc-André Lureau 2017-09-19  685  	 * and <data_off>, and <dma_off>;
75f3e8e4 Gabriel Somlo     2016-01-28  686  	 * there must be no extra characters after the last chunk,
75f3e8e4 Gabriel Somlo     2016-01-28  687  	 * so str[consumed] must be '\0'.
75f3e8e4 Gabriel Somlo     2016-01-28  688  	 */
75f3e8e4 Gabriel Somlo     2016-01-28 @689  	if (str[consumed] ||
46ebd6f8 Marc-André Lureau 2017-09-19  690  	    (processed != 1 && processed != 3 && process != 4))
75f3e8e4 Gabriel Somlo     2016-01-28  691  		return -EINVAL;
75f3e8e4 Gabriel Somlo     2016-01-28  692  
75f3e8e4 Gabriel Somlo     2016-01-28  693  	res[0].start = base;
75f3e8e4 Gabriel Somlo     2016-01-28  694  	res[0].end = base + size - 1;
75f3e8e4 Gabriel Somlo     2016-01-28  695  	res[0].flags = !strcmp(kp->name, "mmio") ? IORESOURCE_MEM :
75f3e8e4 Gabriel Somlo     2016-01-28  696  						   IORESOURCE_IO;
75f3e8e4 Gabriel Somlo     2016-01-28  697  
75f3e8e4 Gabriel Somlo     2016-01-28  698  	/* insert register offsets, if provided */
75f3e8e4 Gabriel Somlo     2016-01-28  699  	if (processed > 1) {
75f3e8e4 Gabriel Somlo     2016-01-28  700  		res[1].name = "ctrl";
75f3e8e4 Gabriel Somlo     2016-01-28  701  		res[1].start = ctrl_off;
75f3e8e4 Gabriel Somlo     2016-01-28  702  		res[1].flags = IORESOURCE_REG;
75f3e8e4 Gabriel Somlo     2016-01-28  703  		res[2].name = "data";
75f3e8e4 Gabriel Somlo     2016-01-28  704  		res[2].start = data_off;
75f3e8e4 Gabriel Somlo     2016-01-28  705  		res[2].flags = IORESOURCE_REG;
75f3e8e4 Gabriel Somlo     2016-01-28  706  	}
46ebd6f8 Marc-André Lureau 2017-09-19  707  	if (processed > 3) {
46ebd6f8 Marc-André Lureau 2017-09-19  708  		res[3].name = "dma";
46ebd6f8 Marc-André Lureau 2017-09-19  709  		res[3].start = dma_off;
46ebd6f8 Marc-André Lureau 2017-09-19  710  		res[3].flags = IORESOURCE_REG;
46ebd6f8 Marc-André Lureau 2017-09-19  711  	}
75f3e8e4 Gabriel Somlo     2016-01-28  712  
75f3e8e4 Gabriel Somlo     2016-01-28  713  	/* "processed" happens to nicely match the number of resources
75f3e8e4 Gabriel Somlo     2016-01-28  714  	 * we need to pass in to this platform device.
75f3e8e4 Gabriel Somlo     2016-01-28  715  	 */
75f3e8e4 Gabriel Somlo     2016-01-28  716  	fw_cfg_cmdline_dev = platform_device_register_simple("fw_cfg",
75f3e8e4 Gabriel Somlo     2016-01-28  717  					PLATFORM_DEVID_NONE, res, processed);
75f3e8e4 Gabriel Somlo     2016-01-28  718  	if (IS_ERR(fw_cfg_cmdline_dev))
75f3e8e4 Gabriel Somlo     2016-01-28  719  		return PTR_ERR(fw_cfg_cmdline_dev);
75f3e8e4 Gabriel Somlo     2016-01-28  720  
75f3e8e4 Gabriel Somlo     2016-01-28  721  	return 0;
75f3e8e4 Gabriel Somlo     2016-01-28  722  }
75f3e8e4 Gabriel Somlo     2016-01-28  723  

:::::: The code at line 689 was first introduced by commit
:::::: 75f3e8e47f381074801d0034874d20c638d9e3d9 firmware: introduce sysfs driver for QEMU's fw_cfg device

:::::: TO: Gabriel Somlo <somlo@cmu.edu>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--LZvS9be/3tNcYl/X
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--LZvS9be/3tNcYl/X--
