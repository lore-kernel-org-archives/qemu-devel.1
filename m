Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6539AC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25EBE20678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EBE20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZt4b-0005ny-41
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 03:53:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1iZsx3-0005gj-Ly
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert@linux-m68k.org>) id 1iZsum-0002o4-Lt
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:43:15 -0500
Received: from andre.telenet-ops.be ([2a02:1800:120:4::f00:15]:45648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert@linux-m68k.org>)
 id 1iZsum-0002lW-9n
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:43:12 -0500
Received: from ramsan ([84.195.182.253]) by andre.telenet-ops.be with bizsmtp
 id Wwiu2100c5USYZQ01wiuXT; Wed, 27 Nov 2019 09:43:07 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1iZsuU-0000xr-Pe; Wed, 27 Nov 2019 09:42:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1iZsuU-0004Ox-Ms; Wed, 27 Nov 2019 09:42:54 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v3 5/7] gpio: Add GPIO Aggregator/Repeater driver
Date: Wed, 27 Nov 2019 09:42:51 +0100
Message-Id: <20191127084253.16356-6-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127084253.16356-1-geert+renesas@glider.be>
References: <20191127084253.16356-1-geert+renesas@glider.be>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:1800:120:4::f00:15
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GPIO controllers are exported to userspace using /dev/gpiochip*
character devices.  Access control to these devices is provided by
standard UNIX file system permissions, on an all-or-nothing basis:
either a GPIO controller is accessible for a user, or it is not.
Currently no mechanism exists to control access to individual GPIOs.

Hence add a GPIO driver to aggregate existing GPIOs, and expose them as
a new gpiochip.

This supports the following use cases:
  1. Aggregating GPIOs using Sysfs
     This is useful for implementing access control, and assigning a set
     of GPIOs to a specific user or virtual machine.

  2. GPIO Repeater in Device Tree
     This supports modelling e.g. GPIO inverters in DT.

  3. Generic GPIO Driver
     This provides userspace access to a simple GPIO-operated device
     described in DT, cfr. e.g. spidev for SPI-operated devices.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Absorb GPIO forwarder,
  - Integrate GPIO Repeater and Generic GPIO driver functionality,
  - Use the aggregator parameters to create a GPIO lookup table instead
    of an array of GPIO descriptors, which allows to simplify the code:
      1. This removes the need for calling gpio_name_to_desc(),
         gpiochip_find(), gpiochip_get_desc(), and gpiod_request(),
      2. This allows the platform device to always use
         devm_gpiod_get_index(), regardless of the origin of the GPIOs,
  - Move parameter parsing from platform device probe to sysfs attribute
    store, removing the need for platform data passing,
  - Use more devm_*() functions to simplify cleanup,
  - Add pr_fmt(),
  - General refactoring.

v2:
  - Add missing initialization of i in gpio_virt_agg_probe(),
  - Update for removed .need_valid_mask field and changed
    .init_valid_mask() signature,
  - Drop "virtual", rename to gpio-aggregator,
  - Drop bogus FIXME related to gpiod_set_transitory() expectations,
  - Use new GPIO Forwarder Helper,
  - Lift limit on the maximum number of GPIOs,
  - Improve parsing:
      - add support for specifying GPIOs by line name,
      - add support for specifying GPIO chips by ID,
      - add support for GPIO offset ranges,
      - names and offset specifiers must be separated by whitespace,
      - GPIO offsets must separated by spaces,
  - Use str_has_prefix() and kstrtouint().
---
 drivers/gpio/Kconfig           |  13 +
 drivers/gpio/Makefile          |   1 +
 drivers/gpio/gpio-aggregator.c | 587 +++++++++++++++++++++++++++++++++
 3 files changed, 601 insertions(+)
 create mode 100644 drivers/gpio/gpio-aggregator.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 8adffd42f8cb0559..36b6b57a6b05e906 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1507,6 +1507,19 @@ config GPIO_VIPERBOARD
 
 endmenu
 
+config GPIO_AGGREGATOR
+	tristate "GPIO Aggregator/Repeater"
+	help
+	  Say yes here to enable the GPIO Aggregator and repeater, which
+	  provides a way to aggregate and/or repeat existing GPIOs into a new
+	  GPIO device.
+	  This can serve the following purposes:
+	    1. Assign a collection of GPIOs to a user, or export them to a
+	       virtual machine,
+	    2. Support GPIOs that are connected to a physical inverter,
+	    3. Provide a generic driver for a GPIO-operated device, to be
+               controlled from userspace using the GPIO chardev interface.
+
 config GPIO_MOCKUP
 	tristate "GPIO Testing Driver"
 	select IRQ_SIM
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 34eb8b2b12dd656c..f9971eeb1f32335f 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_GPIO_74XX_MMIO)		+= gpio-74xx-mmio.o
 obj-$(CONFIG_GPIO_ADNP)			+= gpio-adnp.o
 obj-$(CONFIG_GPIO_ADP5520)		+= gpio-adp5520.o
 obj-$(CONFIG_GPIO_ADP5588)		+= gpio-adp5588.o
+obj-$(CONFIG_GPIO_AGGREGATOR)		+= gpio-aggregator.o
 obj-$(CONFIG_GPIO_ALTERA_A10SR)		+= gpio-altera-a10sr.o
 obj-$(CONFIG_GPIO_ALTERA)  		+= gpio-altera.o
 obj-$(CONFIG_GPIO_AMD8111)		+= gpio-amd8111.o
diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
new file mode 100644
index 0000000000000000..873578c6f9683db8
--- /dev/null
+++ b/drivers/gpio/gpio-aggregator.c
@@ -0,0 +1,587 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// GPIO Aggregator and Repeater
+//
+// Copyright (C) 2019 Glider bvba
+
+#define DRV_NAME       "gpio-aggregator"
+#define pr_fmt(fmt)	DRV_NAME ": " fmt
+
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/ctype.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
+#include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/overflow.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+
+#include "gpiolib.h"
+
+
+	/*
+	 * GPIO Aggregator sysfs interface
+	 */
+
+struct gpio_aggregator {
+	struct gpiod_lookup_table *lookups;
+	struct platform_device *pdev;
+	char args[];
+};
+
+static DEFINE_MUTEX(gpio_aggregator_lock);	/* protects idr */
+static DEFINE_IDR(gpio_aggregator_idr);
+
+static char *get_arg(char **args)
+{
+	char *start = *args, *end;
+
+	while (isspace(*start))
+		start++;
+
+	if (!*start)
+		return NULL;
+
+	if (*start == '"') {
+		/* Quoted arg */
+		end = strchr(++start, '"');
+		if (!end)
+			return ERR_PTR(-EINVAL);
+	} else {
+		/* Unquoted arg */
+		for (end = start; *end && !isspace(*end); end++) ;
+	}
+
+	if (*end)
+		*end++ = '\0';
+
+	*args = end;
+	return start;
+}
+
+static bool isrange(const char *s)
+{
+	size_t n = strlen(s);
+
+	if (IS_ERR_OR_NULL(s))
+		return false;
+
+	while (1) {
+		n = strspn(s, "0123456789");
+		if (!n)
+			return false;
+
+		s += n;
+
+		switch (*s++) {
+		case '\0':
+			return true;
+
+		case '-':
+		case ',':
+			break;
+
+		default:
+			return false;
+		}
+	}
+}
+
+static int aggr_add_gpio(struct gpio_aggregator *aggr, const char *label,
+			 int hwnum, unsigned int *n)
+{
+	struct gpiod_lookup_table *lookups;
+
+	lookups = krealloc(aggr->lookups, struct_size(lookups, table, *n + 2),
+			   GFP_KERNEL);
+	if (!lookups)
+		return -ENOMEM;
+
+	lookups->table[*n].chip_label = label;
+	lookups->table[*n].chip_hwnum = hwnum;
+	lookups->table[*n].idx = *n;
+
+	(*n)++;
+	memset(&lookups->table[*n], 0, sizeof(lookups->table[*n]));
+
+	aggr->lookups = lookups;
+	return 0;
+}
+
+static int aggr_parse(struct gpio_aggregator *aggr)
+{
+	char *name, *offsets, *first, *last, *next;
+	unsigned int a, b, i, n = 0;
+	char *args = aggr->args;
+	int error;
+
+	for (name = get_arg(&args), offsets = get_arg(&args); name;
+	     offsets = get_arg(&args)) {
+		if (IS_ERR(name)) {
+			pr_err("Cannot get GPIO specifier: %ld\n",
+			       PTR_ERR(name));
+			return PTR_ERR(name);
+		}
+
+		if (!isrange(offsets)) {
+			/* Named GPIO line */
+			error = aggr_add_gpio(aggr, name, -1, &n);
+			if (error)
+				return error;
+
+			name = offsets;
+			continue;
+		}
+
+		/* GPIO chip + offset(s) */
+		for (first = offsets; *first; first = next) {
+			next = strchrnul(first, ',');
+			if (*next)
+				*next++ = '\0';
+
+			last = strchr(first, '-');
+			if (last)
+				*last++ = '\0';
+
+			if (kstrtouint(first, 10, &a)) {
+				pr_err("Cannot parse GPIO index %s\n", first);
+				return -EINVAL;
+			}
+
+			if (!last) {
+				b = a;
+			} else if (kstrtouint(last, 10, &b)) {
+				pr_err("Cannot parse GPIO index %s\n", last);
+				return -EINVAL;
+			}
+
+			for (i = a; i <= b; i++) {
+				error = aggr_add_gpio(aggr, name, i, &n);
+				if (error)
+					return error;
+			}
+		}
+
+		name = get_arg(&args);
+	}
+
+	if (!n) {
+		pr_err("No GPIOs specified\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static ssize_t new_device_store(struct device_driver *driver, const char *buf,
+				size_t count)
+{
+	struct gpio_aggregator *aggr;
+	struct platform_device *pdev;
+	int res, id;
+
+	/* kernfs guarantees string termination, so count + 1 is safe */
+	aggr = kzalloc(sizeof(*aggr) + count + 1, GFP_KERNEL);
+	if (!aggr)
+		return -ENOMEM;
+
+	memcpy(aggr->args, buf, count + 1);
+
+	aggr->lookups = kzalloc(struct_size(aggr->lookups, table, 1),
+				GFP_KERNEL);
+	if (!aggr->lookups) {
+		res = -ENOMEM;
+		goto free_ga;
+	}
+
+	mutex_lock(&gpio_aggregator_lock);
+	id = idr_alloc(&gpio_aggregator_idr, aggr, 0, 0, GFP_KERNEL);
+	mutex_unlock(&gpio_aggregator_lock);
+
+	if (id < 0) {
+		res = id;
+		goto free_table;
+	}
+
+	aggr->lookups->dev_id = kasprintf(GFP_KERNEL, "%s.%d", DRV_NAME, id);
+	if (!aggr->lookups) {
+		res = -ENOMEM;
+		goto remove_idr;
+	}
+
+	res = aggr_parse(aggr);
+	if (res)
+		goto free_dev_id;
+
+	gpiod_add_lookup_table(aggr->lookups);
+
+	pdev = platform_device_register_simple(DRV_NAME, id, NULL, 0);
+	if (IS_ERR(pdev)) {
+		res = PTR_ERR(pdev);
+		goto remove_table;
+	}
+
+	aggr->pdev = pdev;
+	return count;
+
+remove_table:
+	gpiod_remove_lookup_table(aggr->lookups);
+free_dev_id:
+	kfree(aggr->lookups->dev_id);
+remove_idr:
+	mutex_lock(&gpio_aggregator_lock);
+	idr_remove(&gpio_aggregator_idr, id);
+	mutex_unlock(&gpio_aggregator_lock);
+free_table:
+	kfree(aggr->lookups);
+free_ga:
+	kfree(aggr);
+	return res;
+}
+
+static DRIVER_ATTR_WO(new_device);
+
+static void gpio_aggregator_free(struct gpio_aggregator *aggr)
+{
+	platform_device_unregister(aggr->pdev);
+	gpiod_remove_lookup_table(aggr->lookups);
+	kfree(aggr->lookups->dev_id);
+	kfree(aggr->lookups);
+	kfree(aggr);
+}
+
+static ssize_t delete_device_store(struct device_driver *driver,
+				   const char *buf, size_t count)
+{
+	struct gpio_aggregator *aggr;
+	unsigned int id;
+	int error;
+
+	if (!str_has_prefix(buf, DRV_NAME "."))
+		return -EINVAL;
+
+	error = kstrtouint(buf + strlen(DRV_NAME "."), 10, &id);
+	if (error)
+		return error;
+
+	mutex_lock(&gpio_aggregator_lock);
+	aggr = idr_remove(&gpio_aggregator_idr, id);
+	mutex_unlock(&gpio_aggregator_lock);
+	if (!aggr)
+		return -ENOENT;
+
+	gpio_aggregator_free(aggr);
+	return count;
+}
+static DRIVER_ATTR_WO(delete_device);
+
+static struct attribute *gpio_aggregator_attrs[] = {
+	&driver_attr_new_device.attr,
+	&driver_attr_delete_device.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(gpio_aggregator);
+
+static int __exit gpio_aggregator_idr_remove(int id, void *p, void *data)
+{
+	gpio_aggregator_free(p);
+	return 0;
+}
+
+static void __exit gpio_aggregator_remove_all(void)
+{
+	mutex_lock(&gpio_aggregator_lock);
+	idr_for_each(&gpio_aggregator_idr, gpio_aggregator_idr_remove, NULL);
+	idr_destroy(&gpio_aggregator_idr);
+	mutex_unlock(&gpio_aggregator_lock);
+}
+
+
+	/*
+	 *  Common GPIO Forwarder
+	 */
+
+struct gpiochip_fwd {
+	struct gpio_chip chip;
+	struct gpio_desc **descs;
+	union {
+		struct mutex mlock;	/* protects tmp[] if can_sleep */
+		spinlock_t slock;	/* protects tmp[] if !can_sleep */
+	};
+	unsigned long tmp[];		/* values and descs for multiple ops */
+};
+
+static int gpio_fwd_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+
+	return gpiod_get_direction(fwd->descs[offset]);
+}
+
+static int gpio_fwd_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+
+	return gpiod_direction_input(fwd->descs[offset]);
+}
+
+static int gpio_fwd_direction_output(struct gpio_chip *chip,
+				     unsigned int offset, int value)
+{
+	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+
+	return gpiod_direction_output(fwd->descs[offset], value);
+}
+
+static int gpio_fwd_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+
+	return gpiod_get_value(fwd->descs[offset]);
+}
+
+static int gpio_fwd_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+				 unsigned long *bits)
+{
+	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+	unsigned long *values, flags;
+	struct gpio_desc **descs;
+	unsigned int i, j = 0;
+	int error;
+
+	if (chip->can_sleep)
+		mutex_lock(&fwd->mlock);
+	else
+		spin_lock_irqsave(&fwd->slock, flags);
+
+	values = &fwd->tmp[0];
+	bitmap_clear(values, 0, fwd->chip.ngpio);
+	descs = (void *)&fwd->tmp[BITS_TO_LONGS(fwd->chip.ngpio)];
+
+	for_each_set_bit(i, mask, fwd->chip.ngpio)
+		descs[j++] = fwd->descs[i];
+
+	error = gpiod_get_array_value(j, descs, NULL, values);
+	if (!error) {
+		j = 0;
+		for_each_set_bit(i, mask, fwd->chip.ngpio)
+			__assign_bit(i, bits, test_bit(j++, values));
+	}
+
+	if (chip->can_sleep)
+		mutex_unlock(&fwd->mlock);
+	else
+		spin_unlock_irqrestore(&fwd->slock, flags);
+
+	return error;
+}
+
+static void gpio_fwd_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+
+	gpiod_set_value(fwd->descs[offset], value);
+}
+
+static void gpio_fwd_set_multiple(struct gpio_chip *chip, unsigned long *mask,
+				  unsigned long *bits)
+{
+	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+	unsigned long *values, flags;
+	struct gpio_desc **descs;
+	unsigned int i, j = 0;
+
+	if (chip->can_sleep)
+		mutex_lock(&fwd->mlock);
+	else
+		spin_lock_irqsave(&fwd->slock, flags);
+
+	values = &fwd->tmp[0];
+	descs = (void *)&fwd->tmp[BITS_TO_LONGS(fwd->chip.ngpio)];
+
+	for_each_set_bit(i, mask, fwd->chip.ngpio) {
+		__assign_bit(j, values, test_bit(i, bits));
+		descs[j++] = fwd->descs[i];
+	}
+
+	gpiod_set_array_value(j, descs, NULL, values);
+
+	if (chip->can_sleep)
+		mutex_unlock(&fwd->mlock);
+	else
+		spin_unlock_irqrestore(&fwd->slock, flags);
+}
+
+static int gpio_fwd_set_config(struct gpio_chip *chip, unsigned int offset,
+			       unsigned long config)
+{
+	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+
+	chip = fwd->descs[offset]->gdev->chip;
+	if (chip->set_config)
+		return chip->set_config(chip, offset, config);
+
+	return -ENOTSUPP;
+}
+
+static int gpio_fwd_init_valid_mask(struct gpio_chip *chip,
+				    unsigned long *valid_mask,
+				    unsigned int ngpios)
+{
+	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+	unsigned int i;
+
+	for (i = 0; i < ngpios; i++) {
+		if (!gpiochip_line_is_valid(fwd->descs[i]->gdev->chip,
+					    gpio_chip_hwgpio(fwd->descs[i])))
+			clear_bit(i, valid_mask);
+	}
+
+	return 0;
+}
+
+/**
+ * gpiochip_fwd_create() - Create a new GPIO forwarder
+ * @dev: Parent device pointer
+ * @ngpios: Number of GPIOs in the forwarder.
+ * @descs: Array containing the GPIO descriptors to forward to.
+ *         This array must contain @ngpios entries, and must not be deallocated
+ *         before the forwarder has been destroyed again.
+ *
+ * This function creates a new gpiochip, which forwards all GPIO operations to
+ * the passed GPIO descriptors.
+ *
+ * Return: An opaque object pointer, or an ERR_PTR()-encoded negative error
+ *         code on failure.
+ */
+static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
+						unsigned int ngpios,
+						struct gpio_desc *descs[])
+{
+	const char *label = dev_name(dev);
+	struct gpiochip_fwd *fwd;
+	struct gpio_chip *chip;
+	unsigned int i;
+	int error;
+
+	fwd = devm_kzalloc(dev, struct_size(fwd, tmp,
+			   BITS_TO_LONGS(ngpios) + ngpios), GFP_KERNEL);
+	if (!fwd)
+		return ERR_PTR(-ENOMEM);
+
+	chip = &fwd->chip;
+
+	for (i = 0; i < ngpios; i++) {
+		dev_dbg(dev, "gpio %u => gpio-%d (%s)\n", i,
+			desc_to_gpio(descs[i]), descs[i]->label ? : "?");
+
+		if (gpiod_cansleep(descs[i]))
+			chip->can_sleep = true;
+		if (descs[i]->gdev->chip->set_config)
+			chip->set_config = gpio_fwd_set_config;
+		if (descs[i]->gdev->chip->init_valid_mask)
+			chip->init_valid_mask = gpio_fwd_init_valid_mask;
+	}
+
+	chip->label = label;
+	chip->parent = dev;
+	chip->owner = THIS_MODULE;
+	chip->get_direction = gpio_fwd_get_direction;
+	chip->direction_input = gpio_fwd_direction_input;
+	chip->direction_output = gpio_fwd_direction_output;
+	chip->get = gpio_fwd_get;
+	chip->get_multiple = gpio_fwd_get_multiple;
+	chip->set = gpio_fwd_set;
+	chip->set_multiple = gpio_fwd_set_multiple;
+	chip->base = -1;
+	chip->ngpio = ngpios;
+	fwd->descs = descs;
+
+	if (chip->can_sleep)
+		mutex_init(&fwd->mlock);
+	else
+		spin_lock_init(&fwd->slock);
+
+	error = devm_gpiochip_add_data(dev, chip, fwd);
+	if (error)
+		return ERR_PTR(error);
+
+	return fwd;
+}
+
+
+	/*
+	 *  Common GPIO Aggregator/Repeater platform device
+	 */
+
+static int gpio_aggregator_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct gpio_desc **descs;
+	struct gpiochip_fwd *fwd;
+	int i, n;
+
+	n = gpiod_count(dev, NULL);
+	if (n < 0)
+		return n;
+
+	descs = devm_kmalloc_array(dev, n, sizeof(*descs), GFP_KERNEL);
+	if (!descs)
+		return -ENOMEM;
+
+	for (i = 0; i < n; i++) {
+		descs[i] = devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
+		if (IS_ERR(descs[i]))
+			return PTR_ERR(descs[i]);
+	}
+
+	fwd = gpiochip_fwd_create(dev, n, descs);
+	if (IS_ERR(fwd))
+		return PTR_ERR(fwd);
+
+	platform_set_drvdata(pdev, fwd);
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id gpio_aggregator_dt_ids[] = {
+	{ .compatible = "gpio-repeater" },
+	/*
+	 * Add GPIO-operated devices controlled from userspace below,
+	 * or use "driver_override" in sysfs
+	 */
+	{},
+};
+MODULE_DEVICE_TABLE(of, gpio_aggregator_dt_ids);
+#endif
+
+static struct platform_driver gpio_aggregator_driver = {
+	.probe = gpio_aggregator_probe,
+	.driver = {
+		.name = DRV_NAME,
+		.groups = gpio_aggregator_groups,
+		.of_match_table = of_match_ptr(gpio_aggregator_dt_ids),
+	},
+};
+
+static int __init gpio_aggregator_init(void)
+{
+	return platform_driver_register(&gpio_aggregator_driver);
+}
+module_init(gpio_aggregator_init);
+
+static void __exit gpio_aggregator_exit(void)
+{
+	gpio_aggregator_remove_all();
+	platform_driver_unregister(&gpio_aggregator_driver);
+}
+module_exit(gpio_aggregator_exit);
+
+MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
+MODULE_DESCRIPTION("GPIO Aggregator/Repeater");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


